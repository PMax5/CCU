import {User} from './authentication';

export interface Concert {
    id ?: number,
    date ?: string,
    name ?: string,
    description ?: string,
    image ?: string,
    participants ?: string[],
    username ?: string,
    status ?: number
}

export interface TextChannel {
    name ?: string,
    messages ?: Array<Message>,
    concertId ?: number
}

export interface VoiceChannel {
    name ?: string,
    status ?: number,
    participants ?: string[],
    concertId ?: number
}

export interface Message {
    author : User,
    message : string
}
