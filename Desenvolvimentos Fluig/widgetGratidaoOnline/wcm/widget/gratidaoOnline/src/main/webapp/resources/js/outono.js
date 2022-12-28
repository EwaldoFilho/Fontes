
var speed=40; // lower number for faster
var leaves=20; // number of leaves falling at a time
var untidy=4; // how often do you want the leaves tidied up (high number is less often)




var boddie;
var dx=new Array();
var xp=new Array();
var yp=new Array();
var am=new Array();
var dy=new Array();
var le=new Array();
var swide=480;
var shigh=320;
var sleft=0;
var starty=0;
var offset=0;
var tidying=0;
var deeex=0;
var has_focus=true;
var ie_version=(navigator.appVersion.indexOf("MSIE")!=-1)?parseFloat(navigator.appVersion.split("MSIE")[1]):false;
var plow=document.createElement("img");
plow.src='data:image/png;base64,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';
var leafy=new Array();
var leaf_image=new Array();
leaf_image[0]='data:image/png;base64,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'+
'AAAABJRU5ErkJggg==';
leaf_image[1]='data:image/png;base64,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';
leaf_image[2]='data:image/png;base64,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';
leaf_image[3]='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABICAMAAABiM0N1AAADAFBMVE'+
'X25ZLg2O/jxJHl3NXvuGz78Vvt12zu5mPv5I/YtV/KqlnUx6Lr0nX33Knnx0jr3STpx0Ht0GTht0'+
'/99Ifp0Gv3493135vq1qDs3Dv14Mv301jwyzjv2bT34MLp2Zj16Wf66nnw31/653337//t3s/26L'+
'/bpmj76WzduXDw1Fnqy2bx1X757PH55Jr103f36rr652r666z58q/y40/ktif65pT77L3dw5zu11'+
'Dz5d/t2jTivYzksnD76qv66bTy4Ij66qb54JDnwSLmvIj55J3467zx16T66Yfx66Hs3dHdrXz445'+
'vyzo/05LD45Z346p/x5nrauXfky3v02Jrsy1vjunj35+Hx2rn756r36ML058zkvIj14r/346705L'+
'bw2acAAADbqxHlupblrhP00aHy4tXy22zYow29ihzfqRj97k7+9jaXeEW1kjF5XhnBsYHpzmn0zA'+
'n564r52l7z0S3+9Dr80jv83Bj91jW6lFMhDgD30CH97SvtuBnz30D57VT+9y7++Bv70UT8yiP3wB'+
'L81xb5ySD96QX+5wT44nv1vQn60D3+1gj94RX+4hv81Db+0TL96R7+6z/5xwX8ySrxtgX8zgT02p'+
'P8zhH98Br92UL6yRb811L852v96iX65F/86jT93yT+9yP+8SH+8An9yQzytwD5xAz90wP98xP+3Q'+
'X7xhL90Cj+7RP+8gz+8gT3wQD91Sv90R395DP92w/3vgX7zAP6xAX1vAL80gH9zxf+5Az9zwn9zg'+
'390Ab7ygL9ygX80AL91gT96gD+0AT90gr+4QL+7wT9zQb+0hD5xAD+8gD/7QH9yAP8xgD94gL+7A'+
'H92AL/5gH9zAH+0QL+1QL92wL8xgP8zgH6wgP+7QP+4AH+4wD9ygL96AH+6wL+1wD+5AL+1AL/6g'+
'D+3wH+5QD90wH+8AD+2gD+zQP+7gD+4gD/4QD+2QH/6gD+0QH/7QD+5AD+1gD+3QD+0wH/7AD+5Q'+
'H+zwH+zQH/6wD+6gD/6QD/6AH+6QD+5gD/5wCaoVpLAAAAYXRSTlO89PTvb13u5ty8/X3rafL789'+
'TxVf5Edcvvloy9tX3ptZDSeFVmfixy38XlwRZzpIuceZ3L5I12iP6n5EyDX2/KhYT3lX5FYV0SBo'+
'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';

function addLoadEvent(funky) {
  var oldonload=window.onload;
  if (typeof(oldonload)!='function') window.onload=funky;
  else window.onload=function() {
    if (oldonload) oldonload();
    funky();
  }
}

addLoadEvent(september_21);

function september_21() { if (document.getElementById) {
  var i;
  if (ie_version) {
    document.onfocusin=function(){has_focus=true;};
    document.onfocusout=function(){has_focus=false;};
  } 
  else {
    window.onfocus=function(){has_focus=true;};
    window.onblur=function(){has_focus=false;};
  }
  
  window.onresize=set_width;
  
  boddie=document.createElement("div");
  boddie.style.position="fixed";
  boddie.style.bottom="0px";
  boddie.style.left="0px";
  boddie.style.width="100%";
  boddie.style.overflow="visible";
  boddie.style.backgroundColor="transparent";
  boddie.style.pointerEvents="none";
  boddie.style.zIndex="0";
  document.body.insertBefore(boddie, document.body.firstChild); 
  set_width();
  plow.style.position="absolute";
  plow.style.overflow="hidden";
  plow.style.zIndex=9999;
  plow.style.bottom="0px";
  plow.style.left="-144px";
  boddie.appendChild(plow);
  for (i=0; i<leaves; i++) start_leaf(Math.random()*shigh*3/4);
  offset=0;
  setInterval("autumn_leaves()", speed);
}}

function start_leaf(whyp) {
  starty++;
  offset++;
  var f, size;
  size=start_fall(starty, whyp);
  f=document.createElement("img");
  f.src=leaf_image[starty%leaf_image.length];
  f.width=size;
  f.style.height="auto";
  f.style.position="absolute";
  f.style.zIndex=1000+starty;
  f.style.top=yp[starty]+"px";
  f.style.left=xp[starty]+"px";
  leafy[starty]=f;
  boddie.appendChild(f);
}
  
function start_fall(i, whyp) {
  var size=72-Math.floor(36*Math.random());
  dx[i]=Math.random();
  am[i]=8+Math.random()*24;
  dy[i]=1+Math.random()*2;
  xp[i]=Math.random()*(swide-size);
  yp[i]=whyp-size;
  le[i]='falling';
  return size;
}

function set_width() {
  var sw, sh;
  if (typeof(window.innerWidth)=='number' && window.innerWidth) {
    sw=window.innerWidth;
    sh=window.innerHeight;
  }
  else if (document.compatMode=="CSS1Compat" && document.documentElement && document.documentElement.clientWidth) {
    sw=document.documentElement.clientWidth;
    sh=document.documentElement.clientHeight; 
  }
  else {
    sw=document.body.clientWidth;
	sh=document.body.clientHeight;
  }
  if (sw && sh && has_focus) {
    swide=sw;
    shigh=sh;
  }
  boddie.style.height=shigh+"px";
}

function autumn_leaves() {
  var i;
  var c=0;
  for (i=0; i<starty; i++) {
    if (leafy[i] && le[i]!='tidying') {
		if (yp[i]>shigh || xp[i]>swide || xp[i]<-leafy[i].width) {
		  if (offset>0) offset--;
		  boddie.removeChild(leafy[i]);
		  leafy[i]=false;
		}
		else if (yp[i]+untidy*offset/leaves<shigh-leafy[i].height/2) {
		  yp[i]+=dy[i];
		  dx[i]+=0.025+Math.random()/10;
		  xp[i]+=deeex;
		  leafy[i].style.top=(yp[i]-am[i]/2*Math.abs(Math.sin(dx[i])))+"px";
		  leafy[i].style.left=(xp[i]+am[i]*Math.sin(dx[i]))+"px";
		}
		else if (le[i]=='falling') le[i]='landed';
	}
	if (leafy[i] && le[i]=='falling') c++;
  }
  if (c<leaves) start_leaf(0);
  if (offset>untidy*leaves && !tidying && Math.random()<.05) tidy_leaves();
}

function tidy_leaves() {
  var i;
  tidying=true;
  for (i=swide; i>=-146; i-=2) setTimeout('plough('+i+')', speed*(swide-i));
  setTimeout('tidying=false; offset=0;', speed*(swide-i));
}

function plough(x) {
  var i, p;
  plow.style.left=x+"px";
  for (i=0; i<starty; i++) {
    if (leafy[i] && le[i]!='falling') {
	  p=xp[i]+leafy[i].width+am[i]*Math.sin(dx[i])-dy[i];
	  if (p<0) {
	    boddie.removeChild(leafy[i]);
		leafy[i]=false;
	  }
	  else if (p>x && p<x+3) {
	    le[i]='tidying';
	    xp[i]-=2;
	    leafy[i].style.left=(xp[i]+am[i]*Math.sin(dx[i]))+"px";
	    if (Math.random()<.1) {
		  yp[i]-=1;
		  leafy[i].style.top=(yp[i]-am[i]/2*Math.abs(Math.sin(dx[i])))+"px";
	    }
	  }
	  else if (p>x+144 && yp[i]<shigh-leafy[i].height/2) {
  	    yp[i]+=dy[i];
		dx[i]+=0.02+Math.random()/10;
		leafy[i].style.top=(yp[i]-am[i]/2*Math.abs(Math.sin(dx[i])))+"px";
		leafy[i].style.left=(xp[i]+am[i]*Math.sin(dx[i]))+"px";
	  }
	}
  }
}