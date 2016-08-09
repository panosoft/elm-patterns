module.exports = {
	entry: {
		index: ['./src/index.js']
	},
	output: {
		path: './dist',
		filename: '[name].js',
	},
	module: {
		loaders: [
            { test: /\.html$/, exclude: /node_modules/, loaders: ['file?name=[name].[ext]'] },
            { test: /\.elm$/, loaders: ['elm-webpack'] }
        ],
		noParse: [/\.elm$/]
	}
}
