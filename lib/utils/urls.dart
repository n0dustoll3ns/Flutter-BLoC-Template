import 'package:pocketbase/pocketbase.dart';

PocketBase pb = PocketBase('https://pocketbase.dancheg97.ru');

const baseUrl = "https://pocketbase.dancheg97.ru";
const filesUrl = "/api/files";
const categoriesFilesUrl = "$baseUrl$filesUrl/categories";
const productsFilesUrl = "$baseUrl$filesUrl/products";
const mainBannerFilesUrl = "$baseUrl$filesUrl/main_banners";
const secondaryBannerFilesUrl = "$baseUrl$filesUrl/secondary_banners";
const tizersIconsUrl = "$baseUrl$filesUrl/tizers";
