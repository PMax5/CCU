import Express from 'express';
import bodyParser from "body-parser";
import {Handlers} from "./handlers";

export class Server {
    private app = Express();
    private handlers = new Handlers();

    constructor(port: number) {
        this.app.listen(port);
        this.app.use(bodyParser.json());
        console.log("Listening http server on port", port);
    }

    async start() {
        this.app.post("/user/signup", (req, res) => {
            this.handlers.createUser(req, res);
        });

        this.app.post("/user/login", (req, res) => {
            this.handlers.loginUser(req, res);
        });

    }



}