import { User } from './models/authentication';
import { Channel, Concert, Message, VoiceChannel, GeneralChannel } from "./models/artist";

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
                username: userUpdated.username !== undefined ? userUpdated.username : user.username,
                name: userUpdated.name !== undefined ? userUpdated.name : user.name,
                email: userUpdated.email !== undefined ? userUpdated.email : user.email,
                password: userUpdated.password !== undefined ? userUpdated.password : user.password,
                imagePath: userUpdated.imagePath !== undefined ? userUpdated.imagePath : user.imagePath,
                description: userUpdated.description !== undefined ? userUpdated.description : user.description,
                type: userUpdated.type !== undefined ? userUpdated.type : user.type
            }

            this.users.set(username, newUser);

            if (user.type === "ARTIST") {
                user.concerts.forEach((concertId: number) => {
                    let concert = this.concerts.get(concertId);
                    if (concert !== undefined) {
                        concert.artistName = user.name,
                            concert.artistImage = user.image
                    }
                });
            }

            return true;
        }

        return false;
    }

    createConcert(username: string, concert: Concert) {
        let concertID = this.concerts.size;
        let user = this.users.get(username);

        if (concert.participants === undefined)
            concert.participants = new Array<string>();
        concert.id = concertID;
        concert.username = username;
        concert.status = this.STATUS_PENDING;
        concert.artistImage = user.imagePath;
        concert.artistName = user.name;
        this.concerts.set(concertID, concert);

        if (user.concerts === undefined)
            user.concerts = new Array<number>();

        let channel = {
            messages: new Array<Message>(),
            name: concert.name
        }

        this.channels.set(concertID, channel);
        user.concerts.push(concertID);
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
        let user = this.users.get(username);

        if (user !== undefined) {
            let userConcertIds = user.concerts;

            if (userConcertIds !== undefined) {
                userConcertIds.forEach((value: number) => {
                    let concert = this.concerts.get(value);
                    if (concert !== undefined)
                        concerts.push(concert);
                });

                return concerts;
            }
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

        if (concert !== undefined && channel !== undefined) {
            let participants = concert.participants;
            if (participants !== undefined && channel.messages !== undefined && participants.includes(message.author.username!)) {
                channel.messages.push(message);
                return channel.messages;
            }
        }

        return [];
    }

    getConcertMessages(id: number) {
        let concert = this.concerts.get(id);
        let channel = this.channels.get(id);

        if (concert !== undefined && channel !== undefined && channel.messages !== undefined) {
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

                console.log("Starting voice call...", channel);
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
            if (user.concerts === undefined)
                user.concerts = new Array<number>();
            user.concerts.push(id);

            if (concert.participants !== undefined)
                concert.participants.push(username);

            return true;
        }

        return false;
    }

    getConcertChannels(username: string) {
        let user = this.users.get(username);
        let allChannels = new Array<GeneralChannel>();

        if (user !== undefined && user.concerts !== undefined) {
            user.concerts.forEach((concertId: number) => {
                let concert = this.concerts.get(concertId);

                if (concert !== undefined) {
                    let channel = this.channels.get(concert.id!);
                    allChannels.push({
                        name: concert.name + " Channel",
                        concertId: concert.id,
                        voice: false
                    });

                    if (user.type === "ARTIST") {
                        allChannels.push({
                            name: concert.name,
                            concertId: concert.id,
                            voice: true,
                            imagePath: user.imagePath
                        });
                    } else {
                        let voiceChannel = this.voiceChannels.get(concert.username!);
                        if (voiceChannel !== undefined &&
                            voiceChannel.participants !== undefined &&
                            voiceChannel.participants.includes(username)) {
                            allChannels.push({
                                name: concert.name,
                                concertId: concert.id,
                                voice: true,
                                imagePath: this.users.get(concert.username).imagePath
                            })
                        }
                    }
                }
            });
        }

        return allChannels;
    }
}