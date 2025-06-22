import 'package:copy_movie/utils/app_assets.dart';
import 'package:copy_movie/utils/app_colors.dart';
import 'package:flutter/material.dart';

void showAvatarBottomSheet(
  BuildContext context,
  int selectedAvatarNumber,
  void Function(int avatarNumber) onAvatarSelected,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1C1C1C),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _AvatarPickerSheet(
      onAvatarSelected: onAvatarSelected,
      selectedAvatarNumber: selectedAvatarNumber,
    ),
  );
}

class _AvatarPickerSheet extends StatefulWidget {
  final void Function(int avatarNumber) onAvatarSelected;
  final int selectedAvatarNumber;

  const _AvatarPickerSheet({
    super.key,
    required this.onAvatarSelected,
    required this.selectedAvatarNumber,
  });

  @override
  State<_AvatarPickerSheet> createState() => _AvatarPickerSheetState();
}

class _AvatarPickerSheetState extends State<_AvatarPickerSheet> {
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedAvatarNumber;
  }

  int? selectedIndex;
  List<String> avatars = [
    AppAssets.character1,
    AppAssets.character2,
    AppAssets.character3,
    AppAssets.character4,
    AppAssets.character5,
    AppAssets.character6,
    AppAssets.character7,
    AppAssets.character8,
    AppAssets.character9,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: avatars.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onAvatarSelected(index);
              Navigator.pop(context); // close the sheet
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Colors.amber
                    : AppColors.transparentColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber, width: 1.2),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.transparentColor,
                backgroundImage: AssetImage(avatars[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
