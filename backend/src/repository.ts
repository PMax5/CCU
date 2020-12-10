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
    private STATUS_CANCELLED = 3;

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
                username : user.username,
                name: userUpdated.name !== undefined ? userUpdated.name : user.name,
                email: user.email,
                password: user.password,
                imagePath: userUpdated.imagePath !== undefined ? userUpdated.imagePath : user.imagePath,
                description: userUpdated.description !== undefined ? userUpdated.description : user.description,
                type: user.type
            }

            this.users.set(username, newUser);
            
            return this.users.get(username);
        }

        return undefined;
    }



    createConcert(username: string, concert: Concert) {
        let concertID = this.concerts.size;
        let user = this.users.get(username);

        concert.id = concertID;
        concert.participants = new Array<string>();
       
        concert.username = username;
        concert.status = this.STATUS_PENDING;
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

}