export interface User {
    username ?: string,
    name ?: string,
    email ?: string,
    password ?: string,
    imagePath ?: string,
    description ?: string,
    type ?: string
}

export interface Login {
    username: string,
    password: string
}