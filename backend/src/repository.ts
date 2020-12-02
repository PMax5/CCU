import {User} from './models/authentication';
import {Concert} from "./models/artist";

export class Repository {

    private users = new Map();
    private concerts = new Map<string, Concert[]>();

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
        concert.id = concerts!.length;
        concerts!.push(concert);
    }

    getArtistConcerts(username: string) {
        return this.concerts.get(username);
    }
}