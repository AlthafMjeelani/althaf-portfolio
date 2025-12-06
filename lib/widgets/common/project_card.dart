import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/project.dart';
import 'project_details_modal.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        scale: _hovering ? 1.02 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _hovering
                  ? [
                      const Color(0xFF1A1F2E).withValues(alpha: 0.95),
                      const Color(0xFF0F1419).withValues(alpha: 0.98),
                    ]
                  : [
                      const Color(0xFF1A1F2E).withValues(alpha: 0.7),
                      const Color(0xFF0F1419).withValues(alpha: 0.85),
                    ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _hovering
                  ? const Color(0xFF00D9FF).withValues(alpha: 0.6)
                  : const Color(0xFF1A1F2E).withValues(alpha: 0.4),
              width: _hovering ? 2 : 1.5,
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: const Color(0xFF00D9FF).withValues(alpha: 0.4),
                      blurRadius: 30,
                      spreadRadius: 0,
                      offset: const Offset(0, 12),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          padding: const EdgeInsets.all(32),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Thumbnail Image
                if (widget.project.thumbnailImagePath != null)
                  GestureDetector(
                    onTap: () => _showProjectDetails(context),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            widget.project.thumbnailImagePath!,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 180,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(
                                        0xFF00D9FF,
                                      ).withValues(alpha: 0.2),
                                      const Color(
                                        0xFF0099CC,
                                      ).withValues(alpha: 0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.image_outlined,
                                  color: Color(0xFF00D9FF),
                                  size: 48,
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF00D9FF), Color(0xFF0099CC)],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'View Details',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (widget.project.thumbnailImagePath != null)
                  const SizedBox(height: 20),
                GestureDetector(
                  onTap: _handleOpenStore,
                  child: Text(
                    widget.project.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D9FF).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    widget.project.tech,
                    style: const TextStyle(
                      color: Color(0xFF00D9FF),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.project.period,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                for (final pt in widget.project.points)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8, right: 12),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00D9FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            pt,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 14,
                              height: 1.6,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                if (widget.project.appStoreUrl != null ||
                    widget.project.playStoreUrl != null)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Wrap(
                      spacing: 10,
                      children: [
                        if (widget.project.playStoreUrl != null)
                          StoreButton(
                            icon: Icons.android,
                            label: 'Play Store',
                            onTap: () => _openUrl(widget.project.playStoreUrl!),
                          ),
                        if (widget.project.appStoreUrl != null)
                          StoreButton(
                            icon: Icons.apple,
                            label: 'App Store',
                            onTap: () => _openUrl(widget.project.appStoreUrl!),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleOpenStore() {
    final hasApple = widget.project.appStoreUrl != null;
    final hasPlay = widget.project.playStoreUrl != null;
    if (hasApple && !hasPlay) {
      _openUrl(widget.project.appStoreUrl!);
    } else if (!hasApple && hasPlay) {
      _openUrl(widget.project.playStoreUrl!);
    } else if (hasApple && hasPlay) {
      _showStoreChooser();
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showStoreChooser() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151923),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StoreButton(
                icon: Icons.apple,
                label: 'App Store',
                onTap: () {
                  Navigator.of(context).pop();
                  _openUrl(widget.project.appStoreUrl!);
                },
              ),
              StoreButton(
                icon: Icons.android,
                label: 'Play Store',
                onTap: () {
                  Navigator.of(context).pop();
                  _openUrl(widget.project.playStoreUrl!);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showProjectDetails(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) => ProjectDetailsModal(project: widget.project),
    );
  }
}

class StoreButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const StoreButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF1A1F2E).withValues(alpha: 0.8),
        side: BorderSide(color: const Color(0xFF00D9FF).withValues(alpha: 0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
