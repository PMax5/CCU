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


    createConcert(username: string, concert: Concert) {
        let concertID = this.concerts.size;
        let user = this.users.get(username);

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

}