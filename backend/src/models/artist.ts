export interface Concert {
    date ?: string,
    time ?: string,
    name ?: string,
    description ?: string,
    link ?: string,
    image ?: string,
    id ?: number,
    participants ?: string[],
    started ?: boolean;
}

export interface Channel {
    name ?: string,
    messages ?: Array<string[]>,
}

export interface VoiceChannel {
    name ?: string,
    participants ?: string[]
}
