import {User} from './models/authentication';

export class Repository {

    private users = new Map();

    createUser(user: User) {
        this.users.set(user.username, user);
    }

    getUser(username: string) {
        return this.users.get(username);
    }
}