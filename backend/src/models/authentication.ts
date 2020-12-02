export interface User {
    username ?: string,
    name ?: string,
    email ?: string,
    password ?: string,
    imagePath ?: string,
    description ?: string,
    type ?: string,
    concerts ?: Array<number>
}

export interface Login {
    username: string,
    password: string
}