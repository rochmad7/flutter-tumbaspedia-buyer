import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:tumbaspedia/cubit/cubit.dart';
import 'package:tumbaspedia/models/models.dart';
import 'package:tumbaspedia/services/services.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:tumbaspedia/shared/shared.dart';
import 'package:tumbaspedia/ui/widgets/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supercharged/supercharged.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'general_page.dart';
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'main_page.dart';
part 'home_page.dart';
part 'order_history_page.dart';
part 'shop_page.dart';
part 'product_page.dart';
part 'profile_page.dart';
part 'all_products_page.dart';
part 'all_shops_page.dart';
part 'product_details_page.dart';
part 'shop_details_page.dart';
part 'illustration_page.dart';
part 'edit_profile_page.dart';
part 'payment_page.dart';
part 'payment_method_page.dart';
part 'success_order_page.dart';
part 'transaction_details_page.dart';
part 'complete_profile_page.dart';
part 'form_complete_profile_page.dart';
part 'forgot_password_page.dart';
part 'change_password_page.dart';
part 'all_reviews_page.dart';
part 'waiting_register_confirmation.dart';

part 'tumbaspedia/payment_instructions_page.dart';
part 'tumbaspedia/help_page.dart';
part 'tumbaspedia/privacy_page.dart';
part 'tumbaspedia/security_page.dart';
part 'tumbaspedia/term_page.dart';
part 'tumbaspedia/about_page.dart';
