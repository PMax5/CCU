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

export interface Channel {
    name ?: string,
    messages ?: Array<Message>,
}

export interface VoiceChannel {
    name ?: string,
    participants ?: string[],
    concertId ?: number
}

export interface Message {
    author : User,
    message : string
}

export interface GeneralChannel {
    name ?: string,
    concertId ?: number,
    voice ?: boolean,
    imagePath ?: string
}