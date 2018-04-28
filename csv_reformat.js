var loader = require('csv-load-sync');
var fs = require('fs');
var path = require('path');
var direc = 'actions2';
var csvFolders = fs.readdirSync(direc);
String.prototype.replaceAt=function(index, replacement) {
    return this.substr(0, index) + replacement+ this.substr(index + replacement.length);
}



for(var i in csvFolders){
	var folder = csvFolders[i];
	var folderPath = path.join(direc,folder );
	//console.log(folder);
	var csvFiles = fs.readdirSync(folderPath);
	//console.log(csvFiles);
	for(var csv_idx in csvFiles){
		var csv_path = path.join(folderPath, csvFiles[csv_idx]);
		var lines = fs.readFileSync(csv_path, 'utf-8')
    .split('\n')
    .filter(Boolean);
	
		for(var i = 1; i < lines.length; i++){
			lines[i] = lines[i].replace(',', '_');
			/*for(var j = 0; j < lines[i].length; j++){
				
				if(lines[i][j] == ','){
					
					//lines[i][j] = '_';
					lines[i] = lines[i].replaceAt(j, "_")
					console.log(csv_path + i);
					//console.log(lines[i]);
					break;
				}
			}*/
		}
		var output = lines.join('\n');
		//console.log(output);
		fs.writeFileSync(csv_path,output);
	}
}

