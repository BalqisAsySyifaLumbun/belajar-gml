R\&D - MOVING PLATFORM DOCUMENTATION

\[Start 26/9/25]

Disusun: Balqis Lumbun

Kontributor: 











Dasar Teori:



GERAK RELATIF - 

Kondisi pandangan pergerakan suatu benda yang dipengaruhi oleh titik acuan tertentu. Benda bergerak dengan kecepatan yang sama dengan penampangnya.





Dasar Rumus yang digunakan:



Rumus posisi Relatif:



Koordinat Relatif Pemain = Koordinat Global Pemain - Koordinat Platform



Koordinat relatif dapat digunakan untuk mengetahui posisi pemain secara relatif dari platformnya, dengan prinsip menjadikan platform alih-alih global sebagai anchor.









Rumus persistensi posisi relatif (vertikal):



Koordinat Vertikal Pemain = Titik Sumbu Atas Platform - ( Titik Sumbu Bawah Pemain- Koordinat Vertikal Pemain)



Koordinat Vertikal Pemain = Koordinat Vertikal Pemain + Kecepatan Vertikal Platform 



Persistensi koordinat vertikal digunakan agar kedudukan player selalu berada di atas penampang selama tidak ada dorongan, mencegah player jatuh dari penampang.





Rumus persistensi posisi relatif (horizontal):



Loop saat pemain berada di atas ground \&\& sedang melompat dari platform{

Koordinat Horizontal Pemain = Koordinat Horizontal Pemain + (Kecepatan Horizontal Platform x Arah Pergerakan Platform)}



Persistensi koordinat horizontal digunakan agar kedudukan player selalu berada di atas penampang selama tidak ada dorongan, mencegah player jatuh dari penampang.



Rumus kecepatan:



Kecepatan = Koordinat horizontal titik asal -  Koordinat horizontal titik tujuanWaktu 

&nbsp;= JarakWaktu



Kecepatan -> satuan pixel/frame

Selisih Koordinat -> satuan titik pixel 

Waktu -> satuan frame



Contoh Potongan Kode:



var platform = instance\_place(x, y + 1, obj\_floating\_wall);



if (platform != noone) {

&nbsp;	

&nbsp;	

&nbsp;	if (x >= platform.bbox\_left \&\& x <= platform.bbox\_right) {

&nbsp;		on\_leap = false;

&nbsp;		var rel\_x = x - platform.x;

&nbsp;	    var rel\_y = y - platform.y;

&nbsp;	    anchor\_id = platform.id;

&nbsp;	

&nbsp;		y = platform.bbox\_top - (bbox\_bottom - y);

&nbsp;		y += platform.vspd;

&nbsp;   

&nbsp;		array\_push(array\_vector, \[platform.hspd, platform.vspd]);

&nbsp;	

&nbsp;		//Supaya bisa jalan di platform bergerak

&nbsp;		if (keyboard\_check(vk\_left) || keyboard\_check(vk\_right)){

&nbsp;			x += hspd;

&nbsp;		}

&nbsp;	

&nbsp;		if (platform.direction\_wall == "vertical") {

&nbsp;			on\_hori\_ground = false;

&nbsp;		}

&nbsp;	

&nbsp;		if (platform.direction\_wall == "horizontal") {

&nbsp;			on\_hori\_ground = true;

&nbsp;			

&nbsp;			x += platform.hspd \* platform.direction\_flag;

&nbsp;		

&nbsp;		

&nbsp;			if (keyboard\_check\_pressed(vk\_up) \&\& on\_hori\_ground){

&nbsp;				locked\_hspd = platform.hspd \* platform.direction\_flag;

&nbsp;				on\_hori\_ground = false;

&nbsp;				on\_leap = true;

&nbsp;			}

&nbsp;	    }

&nbsp;	}

&nbsp;	else{

&nbsp;		platform = noone;

&nbsp;	}

}

else{

&nbsp;	on\_hori\_ground = false;

}



if (on\_leap) {

&nbsp;	x += locked\_hspd;

}

else{

&nbsp;	locked\_hspd = 0;

&nbsp;	x += locked\_hspd;

}





Fungsionalitas:



Pemanfaatan dalam Game Development ASBAK:



Persistensi karakter sorcerer maupun enemy pada platform bergerak dengan pandangan tampak samping, contoh bila Sam berdiri maupun bertarung di atas sekoci yang bergerak.



Limitasi:



Bila player melompat pada saat platform berbalik arah, player akan terlempar keluar karena masih membawa multiplier direction yang lama.

&nbsp;    

Penyempurnaan:













