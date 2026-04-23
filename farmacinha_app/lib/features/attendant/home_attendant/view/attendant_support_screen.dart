import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class AttendantSupportScreen extends StatelessWidget {
  const AttendantSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFAF7),
        surfaceTintColor: const Color(0xFFFFFAF7),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded, color: Pallete.primaryRed),
        ),
        titleSpacing: 0,
        title: const Text(
          'Ajuda e Suporte',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SupportHero(),
              SizedBox(height: 28),
              _SupportCard(
                icon: Icons.mail_rounded,
                iconColor: Pallete.primaryRed,
                iconBackground: Color(0xFFFFF1F2),
                label: 'E-MAIL CORPORATIVO',
                value: 'suportedev@gmail.com',
              ),
              SizedBox(height: 14),
              _SupportCard(
                icon: Icons.phone_in_talk_rounded,
                iconColor: Color(0xFF8A6A14),
                iconBackground: Color(0xFFFFF8DE),
                label: 'WHATSAPP E CENTRAL',
                value: '+55 19 99543-6548',
              ),
              SizedBox(height: 14),
              _SupportScheduleCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportHero extends StatelessWidget {
  const _SupportHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Pallete.accentYellow,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'PORTAL DO ATENDENTE',
            style: TextStyle(
              color: Color(0xFF7A5A00),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 18),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 28,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
            children: [
              TextSpan(
                text: 'Como podemos\n',
                style: TextStyle(color: Color(0xFF212121)),
              ),
              TextSpan(
                text: 'ajudar ',
                style: TextStyle(color: Pallete.primaryRed),
              ),
              TextSpan(
                text: 'hoje?',
                style: TextStyle(color: Color(0xFF212121)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Precisa de aux\u00edlio t\u00e9cnico? Entre em contato com nossa equipe de suporte dedicada. Estamos prontos para garantir a continuidade operacional da sua unidade.',
          style: TextStyle(
            color: Color(0xFF7A5D5A),
            fontSize: 17,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _SupportCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String label;
  final String value;

  const _SupportCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 18),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF9C8E8C),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF27211F),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportScheduleCard extends StatelessWidget {
  const _SupportScheduleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0E8E2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.schedule_rounded,
              color: Color(0xFF6C514D),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOR\u00c1RIO DE ATENDIMENTO',
                  style: TextStyle(
                    color: Color(0xFF4B403F),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Segunda a Sexta, das 08h \u00e0s 18h',
                  style: TextStyle(
                    color: Color(0xFF775F5A),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
