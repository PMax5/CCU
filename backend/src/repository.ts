import {User} from './models/authentication';
import {Channel, Concert, VoiceChannel} from "./models/artist";

export class Repository {

    private users = new Map();
    private concerts = new Map<number, Concert>();
    private channels = new Map<string, Channel>();
    private voiceChannels = new Map<string, VoiceChannel>();

    createUser(user: User) {
        this.users.set(user.username, user);
    }

    getUser(username: string) {
        return this.users.get(username);
    }

    createConcert(username: string, concert: Concert) {
        let concertID = this.concerts.size;

        concert.participants = new Array<string>();
        concert.id = concertID;
        concert.username = username;
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

    startConcert(username: string, id: number) {
        let concert = this.concerts.get(id);

        if (concert !== undefined && concert.username === username) {
            concert.started = true;

            let channel = {
                messages: new Array<string[]>(),
                name: concert.name
            }

            this.channels.set(username, channel);
            return true;
        }

        return false;
    }

    endConcert(username: string, id: number) {
        //this.channels.delete(username);
    }

    startVoiceCall(username: string, id: number) {
        let concert = this.concerts.get(id);
        if (concert !== undefined && concert.username === username) {
            if (concert.participants !== undefined) {
                concert.participants.sort(() => Math.random() - 0.5);

                let channel = {
                    voice: true,
                    participants: concert.participants.slice(0, 3)
                }

                this.voiceChannels.set(username, channel);
                return true;
            }
        }

        return false;
    }
}