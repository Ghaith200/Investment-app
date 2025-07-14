import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:intl/intl.dart';
import 'package:investement_app/core/widgets/custom_textfield.dart';
import 'package:investement_app/features/zoom_meetings/data/zoom_cubit.dart';
import 'package:investement_app/features/zoom_meetings/service/zoom_meeting_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ZoomMeeting extends StatefulWidget {
  const ZoomMeeting({super.key});

  @override
  State<ZoomMeeting> createState() => _ZoomMeetingState();
}

class _ZoomMeetingState extends State<ZoomMeeting>
    with SingleTickerProviderStateMixin {
  final topicController = TextEditingController();
  final agendaController = TextEditingController();
  final dateController = TextEditingController();
  DateTime? selectedDateTime;
  int selectedDuration = 30;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final durations = [15, 30, 45, 60];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    topicController.dispose();
    agendaController.dispose();
    dateController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _pickDateTime() {
    picker.DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2100),
      onConfirm: (dateTime) {
        setState(() {
          selectedDateTime = dateTime;
          dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
        });
      },
      currentTime: DateTime.now().add(const Duration(hours: 1)),
      locale: picker.LocaleType.en,
    );
  }

  Future<void> _joinMeeting(String url) async {
    final uri = Uri.parse(url);
    final zoomSchemeUrl = Uri.parse(
        'zoomus://zoom.us/join?action=join&confno=${_extractMeetingId(url)}');

    if (await canLaunchUrl(zoomSchemeUrl)) {
      await launchUrl(zoomSchemeUrl);
    } else {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _extractMeetingId(String url) {
    final uri = Uri.parse(url);
    return uri.pathSegments.contains('j')
        ? uri.pathSegments[uri.pathSegments.indexOf('j') + 1]
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ZoomMeetingCubit(ZoomMeetingService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Schedule Zoom Meeting'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade50,
                Theme.of(context).scaffoldBackgroundColor,
              ],
            ),
          ),
          child: BlocConsumer<ZoomMeetingCubit, ZoomMeetingState>(
            listener: (context, state) {
              if (state is ZoomMeetingLoaded) {
                _joinMeeting(state.meeting.joinUrl);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    // Animated Zoom logo
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Center(
                          child: Image.asset(
                            'assets/images/zoom.png',
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Form container with shadow and rounded corners
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  controller: topicController,
                                  hintText: 'Enter meeting topic',
                                  label: 'Meeting Topic',
                                  prefixIcon: const Icon(Icons.title),
                                  customValidation: true,
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                  controller: agendaController,
                                  hintText: 'Enter agenda details',
                                  label: 'Agenda',
                                  prefixIcon: const Icon(Icons.description),
                                  customValidation: true,
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                  controller: dateController,
                                  hintText: 'Select date and time',
                                  label: 'Start Date & Time',
                                  prefixIcon: const Icon(Icons.calendar_month),
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  customValidation: true,
                                  readOnly: true,
                                  onTap: _pickDateTime,
                                ),
                                const SizedBox(height: 20),
                                DropdownButtonFormField<int>(
                                  value: selectedDuration,
                                  decoration: InputDecoration(
                                    labelText: 'Duration',
                                    prefixIcon: const Icon(Icons.timer),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                  ),
                                  items: durations
                                      .map((d) => DropdownMenuItem(
                                            value: d,
                                            child: Text('$d minutes'),
                                          ))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => selectedDuration = val!),
                                  borderRadius: BorderRadius.circular(12),
                                  dropdownColor: Colors.white,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: state is ZoomMeetingLoading
                                        ? null
                                        : () {
                                            if (topicController.text.isEmpty ||
                                                agendaController.text.isEmpty ||
                                                selectedDateTime == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Please fill all fields')),
                                              );
                                              return;
                                            }

                                            final formattedTime = DateFormat(
                                                    'yyyy-MM-dd HH:mm:ss')
                                                .format(selectedDateTime!);

                                            context
                                                .read<ZoomMeetingCubit>()
                                                .createMeeting(
                                                  topic: topicController.text
                                                      .trim(),
                                                  agenda: agendaController.text
                                                      .trim(),
                                                  startTime: formattedTime,
                                                  duration: selectedDuration,
                                                );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade700,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: state is ZoomMeetingLoading
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.video_call,
                                                  size: 24),
                                              const SizedBox(width: 12),
                                              Text(
                                                "Create & Join Meeting",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
