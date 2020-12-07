import {User} from './authentication';

export interface Concert {
    date ?: string,
    name ?: string,
    description ?: string,
    link ?: string,
    image ?: string,
    id ?: number,
    participants ?: string[],
    username ?: string,
    status ?: number,
    artistName ?: string,
    artistImage ?: string
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