# Mini Katalog Uygulaması

Bu proje, **Flutter günlük eğitim / proje çıktısı raporunda** istenen maddelere uygun olacak şekilde hazırlanmış basit bir mobil katalog uygulamasıdır.

## Proje Özeti

Uygulamada kullanıcı:

- Ana sayfada ürünleri görebilir
- Ürünleri GridView ile listeleyebilir
- Ürün detay sayfasına geçebilir
- Ürünü sepete ekleyebilir
- Sepet ekranında ürünleri görüntüleyebilir
- JSON veri yapısından ürünleri okuyabilir

## Kullanılan Yapılar

- Flutter
- Dart
- `material.dart`
- `StatelessWidget`
- `StatefulWidget`
- `Navigator.push / pop`
- `MaterialPageRoute`
- JSON veri okuma
- `fromJson / toJson`
- `GridView.builder`
- `ListView`
- Asset kullanımı

## Klasör Yapısı

```bash
lib/
  main.dart
  models/product.dart
  data/products.json
  screens/home_screen.dart
  screens/product_detail_screen.dart
  screens/cart_screen.dart
  widgets/product_card.dart
  services/product_service.dart

assets/
  banner.png
  products/
```

## Çalıştırma Adımları

1. Flutter kurulu olmalıdır.
2. Proje klasörüne girin.
3. Terminalde şu komutları çalıştırın:

```bash
flutter pub get
flutter run
```

## Flutter Sürümü

Bu proje Flutter 3.x ve Dart 3.x yapısına uygun olacak şekilde hazırlanmıştır.

## Proje Teslim İçin Uygun Maddeler

- GitHub'a yüklenebilir proje yapısı vardır
- README.md dosyası vardır
- Ürün liste ekranı vardır
- Ürün detay ekranı vardır
- Sayfa geçişleri vardır
- JSON veri modeli vardır
- Asset kullanımı vardır
- Basit state güncellemesi ile sepet sistemi vardır

## Not

Bu proje **eğitim ve demo amaçlıdır**. Gerçek e-ticaret altyapısı veya canlı sipariş sistemi içermez.
