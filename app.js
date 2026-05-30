const express = require('express'); // Hocam burda const express = require('express') kullandım Çünkü projeme express kütüphanesini dahil edip sunucu altyapımı kurmak istedim.
const session = require('express-session');
const db = require('./config/db');

const app = express(); // Hocam burda const app = express() kullandım Çünkü express fonksiyonunu çalıştırıp uygulamamı bu 'app' değişkeni üzerinden yönetmek istedim.
const port = 3000;

app.set('view engine', 'ejs');

app.use(express.urlencoded({ extended: true })); // Hocam burda bu kodu kullandım Çünkü formlardan gelen kullanıcı verilerini ve girdilerini backend tarafında sorunsuz okuyabilmek istedim.
app.use(express.json());
app.use(express.static('public'));

app.use(session({
    secret: 'motivfit_secret_key',
    resave: false,
    saveUninitialized: true
}));

app.get('/', (req, res) => {
    res.render('index');
});

app.get('/urunler', (req, res) => {
    res.render('urunlerlistesi');
});

app.get('/iletisim', (req, res) => {
    res.render('iletisim'); // Hocam burda res.render kullandım Çünkü kullanıcının karşısına bizim tasarladığımız o iletişim sayfasını tık diye açmak istedim.
});

app.get('/giris', (req, res) => {
    res.render('girisyapvekayitol');
});

app.post('/kayit', (req, res) => {
    const ad = req.body.kayitad; // Hocam burda req.body kullandım Çünkü kayıt formuna kullanıcının yazdığı o isim bilgisini çekip bir değişkene yakalamak istedim.
    const email = req.body.kayitemail;
    const sifre = req.body.kayitsifre;

    const sql = 'INSERT INTO 251109046_users (username, email, password) VALUES (?, ?, ?)';
    
    db.query(sql, [ad, email, sifre], (err, result) => {
        if (err) {
            console.log("Kayıt hatası:", err);
            return res.send("Kayıt sırasında bir hata oluştu.");
        }
        
        res.redirect('/giris');
    });
});

app.post('/giris', (req, res) => {
    const email = req.body.girisemail;
    const sifre = req.body.girissifre;

    const sql = 'SELECT * FROM 251109046_users WHERE email = ? AND password = ?';
    
    db.query(sql, [email, sifre], (err, results) => { // Hocam burda db.query içinde köşeli parantez kullandım Çünkü SQL injection gibi siber saldırıları engelleyip veritabanımı güvende tutmak istedim.
        if (err) {
            console.log("Giriş hatası:", err);
            return res.send("Giriş sırasında bir hata oluştu.");
        }

        if (results.length > 0) { // Hocam burda if kontrolü kullandım Çünkü veritabanından veri döndüyse yani kullanıcının e-postası ve şifresi doğruysa sisteme giriş yaptırmak istedim.
          
            req.session.kullanici = results[0]; 
            
            res.redirect('/');
        } else {
           
            res.send("Hatalı e-posta veya şifre!");
        }
    });
});

app.get('/admin', (req, res) => {
    
    if (req.session.kullanici && req.session.kullanici.role === 'admin') { // Hocam burda bu kontrolü kullandım Çünkü admin paneline sadece admin olan yetkili kişilerin girmesini, kullanıcı olmamış kişilerin girmemesini istedim.
        
        res.render('admin'); 
    } else {
        
        console.log("Yetkisiz erişim denemesi engellendi!");
        res.redirect('/giris');
    }
});

app.post('/egitimler/ekle', (req, res) => {
    const class_name = req.body.class_name;
    const trainer_id = req.body.trainer_id;
    
    const sql = 'INSERT INTO 251109046_classes (class_name, trainer_id) VALUES (?, ?)'; // Hocam burda INSERT ekledim çünkü formdan gelen ders adı,eğitim,fiyat, ve kontejan alıp verı tabanına ekledim.
    db.query(sql, [class_name, trainer_id], (err, result) => {
        if (err) {
            console.log("Ekleme hatası:", err);
            return res.status(500).send("Ekleme hatası.");
        }
        res.redirect('/egitimler');
    });
});

app.post('/egitimler/sil/:id', (req, res) => {
    const dersId = req.params.id;
    
    const sql = 'DELETE FROM 251109046_classes WHERE id = ?';
    
    db.query(sql, [dersId], (err, result) => {
        if (err) {
            console.log("Silme hatası:", err);
            return res.status(500).send("Veritabanı silme hatası.");
        }
        
        res.redirect('/egitimler');
    });
});

app.get('/egitimler', (req, res) => {
    const sql = 'SELECT * FROM 251109046_classes';
    db.query(sql, (err, results) => {
        if (err) {
            console.log("Veri çekme hatası:", err);
            return res.status(500).send("Veritabanı hatası.");
        }
        res.render('egitimler', { siniflar: results });
    });
});

app.post('/egitimler/guncelle/:id', (req, res) => {
    const dersId = req.params.id;
    const { yeni_ucret, yeni_kontenjan } = req.body;
    
    const sql = 'UPDATE 251109046_classes SET price = ?, quota = ? WHERE id = ?';
    
    db.query(sql, [yeni_ucret, yeni_kontenjan, dersId], (err, result) => {
        if (err) {
            console.log("Güncelleme hatası:", err);
            return res.status(500).send("Veritabanı güncelleme hatası.");
        }
        res.redirect('/egitimler');
    });
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`); // Hocam burda console.log kullandım Çünkü projemi ayağa kaldırdım da terminal ekranında sunucunun başarıyla çalıştığını canlı canlı görmek istedim.
});