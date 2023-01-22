import 'package:pocketbase/pocketbase.dart';

PocketBase pb = PocketBase(localUrl);

const baseUrl = "https://pocketbase.dancheg97.ru";
const localUrl = "http://127.0.0.1:8090";
const filesUrl = "/api/files";
const categoriesFilesUrl = "$baseUrl$filesUrl/categories";
const productsFilesUrl = "$baseUrl$filesUrl/products";
const mainBannerFilesUrl = "$baseUrl$filesUrl/main_banners";
const secondaryBannerFilesUrl = "$baseUrl$filesUrl/secondary_banners";
const tizersIconsUrl = "$baseUrl$filesUrl/tizers";
const brandsImagesUrl = "$baseUrl$filesUrl/brands";
const promoImagesUrl = "$baseUrl$filesUrl/promo";
const aboutShopImagesUrl = "$baseUrl$filesUrl/about_shop";
