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
    voice ?: boolean,
    name ?: string,
    messages ?: Array<string[]>
}
