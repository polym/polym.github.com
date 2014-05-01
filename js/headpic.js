	 var number = Math.floor(5 * Math.random());
//	 document.write(number);
     var timeOut = null;
     var picture = new Array(5);
     for (var i = 0; i < picture.length; i++){
         picture[i] = new Image();
     }
     function loadImage(){
		 picture[0].src = "/photo/header/trolley.jpg";
		 picture[1].src = "/photo/header/shore.jpg";
		 picture[2].src = "/photo/header/lanterns.jpg";
		 picture[3].src = "/photo/header/hanoi.jpg";
		 picture[4].src = "/photo/header/chessboard.jpg";
     }
     function playImage(){
         document.head_pic.src = picture[number].src;
         number = (number + 1) % 5;
         timeOut = setTimeout("playImage()", 30000);
     }

