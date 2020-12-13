import { User , Notification } from './models/authentication';
import { TextChannel, Concert, Message, VoiceChannel } from "./models/artist";

export class Repository {

    private users = new Map();
    private concerts = new Map<number, Concert>();
    private channels = new Map<number, TextChannel>();
    private voiceChannels = new Map<number, VoiceChannel>();

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
            return newUser;
        }
       return undefined
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

    endCall(id: number) {
        let voiceCall = this.voiceChannels.get(id);

        if (voiceCall !== undefined  && voiceCall.status === this.STATUS_STARTED) {
            voiceCall.status = this.STATUS_ENDED;
            this.voiceChannels.set(id,voiceCall);
            
            return true;
        }

        return false;
    }

    startCall(id: number) {
        let voiceCall = this.voiceChannels.get(id);

        if (voiceCall !== undefined && voiceCall.status === this.STATUS_PENDING) {
            voiceCall.status = this.STATUS_STARTED;
            this.voiceChannels.set(id,voiceCall);
            
            return true;
        }

        return false;
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

    sendConcertMessages(concertId: number, message: Message){
        let concert = this.concerts.get(concertId);
        let channel = this.channels.get(concertId);
        if(concert !== undefined && channel !== undefined && channel.messages !== undefined)
        {
            let participants = concert.participants;
            if(participants !== undefined && message.author.username !== undefined && (participants.includes(message.author.username) || concert.username === message.author.username))
            {
                channel.messages.push(message);
                this.channels.set(concertId,channel);
                return channel.messages;
            }
        }
        return [];
    }

    getConcertMessages(concertId: number){
        let concert = this.concerts.get(concertId);
        let channel = this.channels.get(concertId);
        if(concert !== undefined && channel !== undefined && channel.messages !== undefined)
            return channel.messages;
        return [];
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


    deleteNotification(fanUsername: string, notification: Notification)
    {
        let user = this.users.get(fanUsername);
        console.log(user);
        let index = user.notifications.indexOf(notification.notification);
        user.notifications.splice(index,1);
        return user;
    }

    addNotification(fanUsername: string, notification: Notification)
    {
        let user = this.users.get(fanUsername);
        user.notifications.push(notification.notification);
        this.users.set(fanUsername,user);
        return user;
    }

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
                name: concert.name,
                concertId: concert.id
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
    getTextChannels(username: string){
        let user = this.users.get(username);
        let channels = new Array<TextChannel>();
        if(user !== undefined && user.concerts !== undefined)
        {
            user.concerts.forEach((value: number) => {
                let channel = this.channels.get(value);
                if (channel !== undefined)
                    channels.push(channel);
            });    
        }
        return channels;
    }

    getTextChannel(id: number){
        let channel = this.channels.get(id);
        return channel;
    }

    getVoiceChannels(username: string){
        let user = this.users.get(username);
        let channels = new Array<VoiceChannel>();
        if(user !== undefined && user.concerts !== undefined)
        {
            user.concerts.forEach((value: number) => {
                let voiceChannel = this.voiceChannels.get(value);
                if (voiceChannel !== undefined)
                    channels.push(voiceChannel);
            });    
        }
        return channels;
    }

    endConcert(username: string, id: number) {
        let concert = this.concerts.get(id);
        if (concert !== undefined && concert.username === username && concert.status === this.STATUS_STARTED && concert.participants !== undefined) {
            let participantsVoice = new Array<String>();
            if(concert.participants.length >= 3)
            {
                let allParticipants = concert.participants;
                while(participantsVoice.length != 3)
                {
                    let participant = allParticipants[Math.floor(Math.random() * allParticipants.length)];
                    if (participantsVoice.indexOf(participant) === -1)
                        participantsVoice.push(participant);
                    
                }
                participantsVoice.push(username);
                let voiceChannel = {
                    status: this.STATUS_PENDING,
                    participants: participantsVoice,
                    name: concert.name,
                    concertId: id
                }
                this.voiceChannels.set(id, voiceChannel);
            }
            concert.status = this.STATUS_ENDED;
           

            return true;
        }
        return false;
    }

    getUsers(username: string, concertId: number) {
        let users = new Array<User>();
        let user_logged = this.users.get(username);
        let concert = this.voiceChannels.get(concertId);

        if (concert !== undefined && user_logged !== undefined) {
            let userConcertIds = concert.participants;
            if(user_logged.type == "FAN")
            {
                if (userConcertIds !== undefined) {
                    userConcertIds.forEach((value: String) => { 
                        let user = this.users.get(value);
                        if (user !== undefined && user.type == "ARTIST")
                            users.push(user);
                        
                     
                    });
                }
            }
            else
            {
                if (userConcertIds !== undefined) {
                    userConcertIds.forEach((value: String) => { 
                        if(user_logged.username != value){
                            let user = this.users.get(value);
                            if (user !== undefined)
                                users.push(user);
                        }
                     
                    });
                }
                        
            }
             return users;
            }
        return [];
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