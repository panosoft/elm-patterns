require('./index.html')
const App = require('./Main.elm')


const app = App.Main.fullscreen()


app.ports.output.subscribe(value => console.log("output:", value))


let i = 0
setInterval(() => app.ports.input.send(i++), 1000)
