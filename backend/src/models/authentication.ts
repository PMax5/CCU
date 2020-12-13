export interface User {
    username ?: string,
    name ?: string,
    email ?: string,
    password ?: string,
    imagePath ?: string,
    description ?: string,
    type ?: string,
    concerts ?: Array<number>,
    favorites ?: Array<string>,
    notifications ?: Array<string>
}

export interface Login {
    username: string,
    password: string
}

export interface Notification {
    notification: string
}