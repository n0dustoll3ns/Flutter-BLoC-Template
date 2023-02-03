import 'package:pocketbase/pocketbase.dart';

const baseUrl = "https://pocketbase.dancheg97.ru";
const localUrl = "http://127.0.0.1:8090";
const currentUrl = baseUrl;

const filesUrl = "/api/files";
const categoriesFilesUrl = "$currentUrl$filesUrl/categories";
const productsFilesUrl = "$currentUrl$filesUrl/products";
const mainBannerFilesUrl = "$currentUrl$filesUrl/main_banners";
const secondaryBannerFilesUrl = "$currentUrl$filesUrl/secondary_banners";
const tizersIconsUrl = "$currentUrl$filesUrl/tizers";
const brandsImagesUrl = "$currentUrl$filesUrl/brands";
const promoImagesUrl = "$currentUrl$filesUrl/promo";
const aboutShopImagesUrl = "$currentUrl$filesUrl/about_shop";
const userDataFilesUrl = "$currentUrl$filesUrl/users";

PocketBase pb = PocketBase(currentUrl);