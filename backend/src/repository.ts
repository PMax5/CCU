import {User} from './models/authentication';
import {Channel, Concert, VoiceChannel} from "./models/artist";

export class Repository {

    private users = new Map();
    private concerts = new Map<string, Concert[]>();
    private channels = new Map<string, Channel>();
    private voiceChannels = new Map<string, VoiceChannel>();

    createUser(user: User) {
        this.users.set(user.username, user);
    }

    getUser(username: string) {
        return this.users.get(username);
    }

    createConcert(username: string, concert: Concert) {
        let concerts = this.getArtistConcerts(username);
        if (concerts === undefined)
            this.concerts.set(username, new Array<Concert>());

        concerts = this.getArtistConcerts(username);
        concert.participants = new Array<string>();
        concert.id = concerts!.length;
        concerts!.push(concert);
    }

    updateConcert(username: string, id: number, concert: Concert) {
        let concerts = this.getArtistConcerts(username);
        if (concerts !== undefined) {
            concerts[id] = concert;
            return true;
        }

        return false;
    }

    getArtistConcerts(username: string) {
        return this.concerts.get(username);
    }

    startConcert(username: string, id: number) {
        let concerts = this.getArtistConcerts(username);
        if (concerts !== undefined) {
            let concert = concerts[id];
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
        this.channels.delete(username);
    }

    startVoiceCall(username: string, id: number) {
        let concerts = this.getArtistConcerts(username);
        if (concerts !== undefined) {
            let concert = concerts[id];

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