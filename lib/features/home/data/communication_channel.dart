import 'package:flutter/material.dart';
import 'package:holly_quran/features/home/data/communication_whatsapp_numbers.dart';

enum CommunicationChannel {
  fatwa,
  emergency,
  complaints,
  hotel,
}

extension CommunicationChannelX on CommunicationChannel {
  String get title {
    switch (this) {
      case CommunicationChannel.fatwa:
        return 'طلب فتوى';
      case CommunicationChannel.emergency:
        return 'رقم الطوارئ';
      case CommunicationChannel.complaints:
        return 'الشكاوى والمقترحات';
      case CommunicationChannel.hotel:
        return 'الخدمات الفندقية';
    }
  }

  String get sheetSubtitle {
    switch (this) {
      case CommunicationChannel.fatwa:
        return 'تواصل مع الموجه الديني عبر واتساب';
      case CommunicationChannel.emergency:
        return 'بلاغ طارئ — يُرسل عبر واتساب';
      case CommunicationChannel.complaints:
        return 'شكوى أو مقترح — يُرسل عبر واتساب';
      case CommunicationChannel.hotel:
        return 'طلب أو الابلاغ خدمة فندقية — يُرسل عبر واتساب';
    }
  }

  String get waDigits {
    switch (this) {
      case CommunicationChannel.fatwa:
        return CommunicationWhatsAppNumbers.fatwa;
      case CommunicationChannel.emergency:
        return CommunicationWhatsAppNumbers.emergency;
      case CommunicationChannel.complaints:
        return CommunicationWhatsAppNumbers.complaintsAndSuggestions;
      case CommunicationChannel.hotel:
        return CommunicationWhatsAppNumbers.hotelServices;
    }
  }

  String get typeFieldLabel {
    switch (this) {
      case CommunicationChannel.fatwa:
        return 'نوع / مجال الفتوى';
      case CommunicationChannel.emergency:
        return 'نوع البلاغ';
      case CommunicationChannel.complaints:
        return 'النوع';
      case CommunicationChannel.hotel:
        return 'نوع الطلب';
    }
  }

  List<String> get categoryOptions {
    switch (this) {
      case CommunicationChannel.fatwa:
        return [
          'عقيدة',
          'فقه الطهارة',
          'فقه المعاملات',
          'صيام وصلاة',
          'أخرى',
        ];
      case CommunicationChannel.emergency:
        return [
          'حالة صحية',
          'أمني / تجمهر',
          'ضياع / تائه',
          'مفقودات',
          'أخرى',
        ];
      case CommunicationChannel.complaints:
        return [
          'شكوى',
          'مقترح',
        ];
      case CommunicationChannel.hotel:
        return [
          'الغرفة والنظافة',
          'الطعام',
          'الاستقبال',
          'صيانة',
          'أخرى',
        ];
    }
  }

  Color get accentColor {
    switch (this) {
      case CommunicationChannel.fatwa:
        return const Color(0xFF0F5847);
      case CommunicationChannel.emergency:
        return const Color(0xFFC0392B);
      case CommunicationChannel.complaints:
        return const Color(0xFF1E5A7A);
      case CommunicationChannel.hotel:
        return const Color(0xFF7D6608);
    }
  }

  IconData get icon {
    switch (this) {
      case CommunicationChannel.fatwa:
        return Icons.menu_book_rounded;
      case CommunicationChannel.emergency:
        return Icons.warning_amber_rounded;
      case CommunicationChannel.complaints:
        return Icons.feedback_outlined;
      case CommunicationChannel.hotel:
        return Icons.room_service_outlined;
    }
  }
}
