import {User} from './models/authentication';
import {Channel, Concert, Message, VoiceChannel} from "./models/artist";

export class Repository {

    private users = new Map();
    private concerts = new Map<number, Concert>();
    private channels = new Map<number, Channel>();
    private voiceChannels = new Map<string, VoiceChannel>();

    private STATUS_PENDING = 0;
    private STATUS_STARTED = 1;
    private STATUS_ENDED = 2;

    createUser(user: User) {
        this.users.set(user.username, user);
    }

    getUser(username: string) {
        return this.users.get(username);
    }

    updateUser(username: string, userUpdated: User) {
        let user = this.users.get(username);

        if (user !== undefined) {
            let newUser = {
                username : userUpdated.username !== undefined ? userUpdated.username : user.username,
                name: userUpdated.name !== undefined ? userUpdated.name : user.name,
                email: userUpdated.email !== undefined ? userUpdated.email : user.email,
                password: userUpdated.password !== undefined ? userUpdated.password : user.password,
                imagePath: userUpdated.imagePath !== undefined ? userUpdated.imagePath : user.imagePath,
                description: userUpdated.description !== undefined ? userUpdated.description : user.description,
                type: userUpdated.type !== undefined ? userUpdated.type : user.type
            }

            this.users.set(username, newUser);
            return true;
        }

        return false;
    }

    createConcert(username: string, concert: Concert) {
        let concertID = this.concerts.size;

        concert.participants = new Array<string>();
        concert.id = concertID;
        concert.username = username;
        concert.status = this.STATUS_PENDING;
        this.concerts.set(concertID, concert);

        let userConcerts = this.users.get(username).concerts;
        if (userConcerts === undefined)
            userConcerts = new Array<number>();

        userConcerts.push(concertID);
    }

    updateConcert(username: string, id: number, concertUpdated: Concert) {
        let concert = this.concerts.get(id);
        if (concert !== undefined) {
            this.concerts.set(id, concertUpdated);
            return true;
        }

        return false;
    }

    getArtistConcerts(username: string) {
        let concerts = new Array<Concert>();
        let userConcertIds = this.users.get(username).concerts;

        if (userConcertIds !== undefined) {
            userConcertIds.forEach((value: number) => {
                let concert = this.concerts.get(value);
                if (concert !== undefined)
                    concerts.push(concert);
            });

            return concerts;
        }

        return [];
    }

    getAllConcerts() {
        return this.concerts;
    }

    startConcert(username: string, id: number) {
        let concert = this.concerts.get(id);

        if (concert !== undefined && concert.username === username) {
            concert.status = this.STATUS_STARTED;

            let channel = {
                messages: new Array<Message>(),
                name: concert.name
            }

            this.channels.set(id, channel);
            return true;
        }

        return false;
    }

    endConcert(username: string, id: number) {
        let concert = this.concerts.get(id);
        if (concert !== undefined && concert.username === username) {
            concert.status = this.STATUS_ENDED;
        }
    }

    sendConcertMessage(id: number, message: Message) {
        let concert = this.concerts.get(id);
        let channel = this.channels.get(id);

        if (concert !== undefined && channel !== undefined && concert.status === this.STATUS_STARTED) {
            let participants = concert.participants;
            if (participants !== undefined && channel.messages !== undefined && participants.includes(message.authorUserName)) {
                channel.messages.push(message);
                return channel.messages;
            }
        }

        return [];
    }

    getConcertMessages(id: number) {
        let concert = this.concerts.get(id);
        let channel = this.channels.get(id);

        if (concert !== undefined && channel !== undefined && channel.messages !== undefined && concert.status === this.STATUS_STARTED) {
            return channel.messages;
        }

        return [];
    }

    startVoiceCall(username: string, id: number) {
        let concert = this.concerts.get(id);
        if (concert !== undefined && concert.username === username) {
            if (concert.participants !== undefined) {
                concert.participants.sort(() => Math.random() - 0.5);

                let channel = {
                    name: concert.name,
                    participants: concert.participants.slice(0, 3),
                    concertId: concert.id
                }

                this.voiceChannels.set(username, channel);
                return channel;
            }
        }

        return null;
    }

    endVoiceCall(username: string, id: number) {
        let concert = this.concerts.get(id);
        let channel = this.voiceChannels.get(username);

        if (channel !== undefined && concert !== undefined && concert.status === this.STATUS_ENDED) {
            this.voiceChannels.delete(username);
            return true;
        }

        return false;
    }

    purchaseTicket(username: string, id: number) {
        let concert = this.concerts.get(id);
        let user = this.users.get(username);

        if (concert !== undefined && user !== undefined) {
            user.concerts.push(id);
            return true;
        }

        return false;
    }
}