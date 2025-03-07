## Pembuatan Level Baru
### Pembuatan World:
#### Menggunakan Tile Map:
Pertama-tama, dibuat world building menggunakan `TileMapLayer`. Asset yang digunakan dalam Tile Map adalah `spritesheet_gr_dirt.png`.

#### Membuat Movable World (Moving Platform, Falling Platform)
Untuk membuat Moving Platform, diimplementasikan didalam `HalfMoonPlatform.tscn`, yang mengandung `StaticBody2D` dengan tekstur dan collisionnya.
Animasi untuk moving platform diatur dalam main scene, menggunakan `AnimationPlayer` node, dengan mengubah nilai position pada keyframe tertentu.

Sedangkan, untuk membuat Falling Platform, diimplementasikan didalam `FallingPlatform.tscn`, yang berupa `RigidBody2D` (dengan `freeze` bernilai `true` diawal) mengandung tekstur, collision, dan juga `Area2D` serta `Timer`.
`Area2D` dan `Timer` diatur sedemikian rupa sehingga ketika `Player` terdeteksi di atas platform, maka timer akan distart, dan setelah beberapa saat, akan mengubah nilai `freeze` menjadi `false`, sehingga platform akan berjatuhan.
Selain itu, ditambahkan juga `AnimationPlayer`, yang memberi efek *shaking* pada platform ketika timer di start.

### Pembuatan Enemy:
#### Spawner Bug
Bug adalah musuh yang ada di game ini.
Bug berupa `StaticBody2D` yang memiliki tekstur dan collision, dua `AnimationPlayer` yang bertugas untuk memberi animasi berjalan dan juga memberi gerakan bolak-balik di atas platform, serta `Area2D` dan collisionnya yang diatur untuk mentrigger kondisi *lose* ketika bersentuhan dengan `Player`.

### Lose & Win:
#### Pembuatan LoseScreen & WinScreen
Ide implementasinya adalah, ketika terjadi kondisi lose atau win, maka muncul overlay gambar yang memperlihatkan win atau lose.
Ini diatur menggunakan `CanvasLayer` yang akan membuat gambar yang di overlay memiliki posisi relatif dengan camera/viewport, sehingga akan selalu terlihat ketika kondisi win/lose.

Selain itu, diberikan animasi `Fade In` dan `Fade out` pada WinScreen dan LoseScreen, yang akan terpicu ketika kondisi lose atau win terpenuhi

#### Kondisi Win
Kondisi win terjadi ketika `Player` menyentuh `WinArea`, yang akan memicu overlay `WinScreen`.
Ketika sudah masuk kondisi ini, pemain dapat menekan tombol `R` untuk restart game dan mulai dari awal, dengan memanfaatkan `get_tree().reload_current_scene()`.


#### Kondisi Lose
Kondisi lose terpicu ketika `Player` bertabrakan dengan `Bug`, atau `Player` jatuh ke jurang dan menyentuh `DeadArea` yang sudah disetup di area bawah Map.
Ketika kondisi lose terpicu, maka overlay `LoseScreen` akan terpicu, bersamaan dengan `Timer` yang diset selama 3.7s, dan akan memicu restart game otomatis ketika timer habis.


### Implementasi tambahan
#### Penggunaan Parallax Background
Pada tutorial ini, digunakan parallax background, walaupun hanya satu layer saja, dengan memanfaatkan asset background yang tersediea di project.

#### Improvisasi pada Movement
Pada saat mengetes game, pergerakan ketika menuruni slope menurut saya cukup *annoying*, contoh ketika kita menekan tombol kanan pada *ramp down* ke kanan, maka `Player` akan terbang dan memantul-mantul sepanjang ramp down.
Ketika saya menekan tombol jump, akan seringkali tidak terbaca karena mayoritas waktu ada di udara, sedangkan jump hanya dapat diisu ketika `is_on_floor()` terpenuhi.

Oleh itu, saya memanfaatkan `get_floor_normal` yang akan mengembalikan (+,+) ketika berada di *ramp down* ke kanan, dan mengembalikan (-,+) ketika berada di *ramp down* ke arah kiri.
Dengan memanfaatkan properti ini, beserta `is_on_floor`, saya menambahkan extra velocity.y yang mendorong `Player` ke bawah ketika menuruni ramp bersamaan dengan menekan tombol kanan/kiri yang bersesuaian dengan arah ramp turun, sehingga `Player` tidak akan memantul-mantul.
Hal ini juga memberi kesan lebih baik pada input jump di ramp down, dengan input jump selalu dapat dibaca, karena mayoritas waktu, `Player` benar-benar ada di lantai.
