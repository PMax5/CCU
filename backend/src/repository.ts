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
        if (user !== undefined)
        {
            let newUser = {
                username: user.username,
                name: user.name,
                email: user.email,
                password: user.password,
                imagePath: user.imagePath,
                description: user.description,
                type:user.type,
                concerts: new Array<number>(),
                favorites:user.type==='FAN'? new Array<string>() : undefined,
                notifications:user.type==='FAN'? new Array<string>() : undefined
            }
            this.users.set(user.username, newUser);
        }
       
    }

    getUser(username: string) {
        return this.users.get(username);
    }   

    updateUser(username: string, userUpdated: User) {
        let user = this.users.get(username);

        if (user !== undefined) {
            user.name = userUpdated.name !== undefined ? userUpdated.name : user.name;
            user.imagePath = userUpdated.imagePath !== undefined ? userUpdated.imagePath: user.imagePath;
            user.description = userUpdated.description !== undefined ? userUpdated.description : user.description ;
            if (user.type == "FAN") {
                user.notifications = userUpdated.notifications !== undefined ? userUpdated.notifications : user.notifications;
            }
                 
            this.users.set(username, user);
            
            return this.users.get(username);
        }

        return undefined;
    }

    followArtist(fanUsername: string, artistUsername: string)
    {
        let user = this.users.get(fanUsername);
        user.favorites.push(artistUsername);
        return user;
    }

    unfollowArtist(fanUsername: string, artistUsername: string)
    {
        let user = this.users.get(fanUsername);
        let index =  user.favorites.indexOf(artistUsername);
        user.favorites.splice(index, 1);
        return user;
    }

    purchaseTicket(username: string, id: number) {
        let concert = this.concerts.get(id);
        let user = this.users.get(username);

        if (concert !== undefined && user !== undefined && concert.participants !== undefined && concert.status == 0) {
            user.concerts.push(id);
            concert.participants.push(username);
            return user;
        }

        return undefined;
    }


    returnTicket(username: string, id: number) {
        let concert = this.concerts.get(id);
        let user = this.users.get(username);

        if (concert !== undefined && user !== undefined && concert.participants !== undefined && concert.status == 0) {
            let index =  user.concerts.indexOf(id);
            user.concerts.splice(index, 1);
            index =  concert.participants.indexOf(username);
            concert.participants.splice(index, 1);

            return user;
        }

        return undefined;
    }


 /*   deleteNotification(fanUsername: string, notification: string)
    {
        let user = this.users.get(fanUsername);
        let index = user.notifications.indexOf(notification);
        user.notifications.splice(index,1);
    }
*/
    createConcert(username: string, concert: Concert) {
        let concertID = this.concerts.size;
        let user = this.users.get(username);

        if(user !== undefined)
        {
            concert.id = concertID;
            concert.participants = new Array<string>();
            concert.username = username;
            concert.status = this.STATUS_PENDING;
            this.concerts.set(concertID, concert);

            user.concerts.push(concertID);

            let channel = {
                messages: new Array<Message>(),
                name: concert.name
            }

            this.channels.set(concertID, channel);
            return true;
        }
       return false;
        
    }

    updateConcert(concertId: number, concert: Concert) {
        let concertResult = this.concerts.get(concertId);

        if (concertResult !== undefined) {
            concertResult.name = concert.name !== undefined ? concert.name : concertResult.name;
            concertResult.date = concert.date !== undefined ? concert.date: concertResult.date;
            concertResult.description = concert.description !== undefined ? concert.description : concertResult.description ;
            concertResult.image = concert.image !== undefined ? concert.image : concertResult.image;
                 
            this.concerts.set(concertId, concertResult);
            
            return true;
        }
        return false;        
    }


    startConcert(username: string, id: number) {
        let concert = this.concerts.get(id);

        if (concert !== undefined && concert.username === username && concert.status === this.STATUS_PENDING) {
            concert.status = this.STATUS_STARTED;
            return true;
        }

        return false;
    }

    cancelConcert(username: string, id: number) {
        let concert = this.concerts.get(id);
        if (concert !== undefined && concert.username === username && concert.status === this.STATUS_PENDING) {
            concert.status = this.STATUS_CANCELLED;
            return true;
        }
        return false;
    }

    endConcert(username: string, id: number) {
        let concert = this.concerts.get(id);
        if (concert !== undefined && concert.username === username && concert.status === this.STATUS_STARTED) {
            concert.status = this.STATUS_ENDED;
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

}