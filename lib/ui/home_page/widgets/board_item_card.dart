part of '../home_page.dart';

class BoardItemCard extends ConsumerWidget {
  const BoardItemCard(this.item, {super.key});
  final Row_ item;
  // final BoardViewController boardViewController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            offset: Offset(1, 2),
          )
        ],
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey[800],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name ?? '',
                style: theme.bodyMedium?.copyWith(color: Colors.grey.shade50),
              ),
              if (item.description?.isNotEmpty ?? false)
                Text(
                  item.description ?? '',
                  style: theme.bodySmall?.copyWith(color: Colors.grey.shade400),
                  maxLines: 3,
                ),
              const SizedBox(height: 5),
              Text(
                "ID ${item.indicatorToMoId}",
                style: theme.bodySmall?.copyWith(color: Colors.grey.shade400),
              ),
              Text(
                "PID ${item.parentId}",
                style: theme.bodySmall?.copyWith(color: Colors.grey.shade400),
              ),
            ],
          ),
          Positioned(
              right: -5,
              top: -7,
              child: Text(
                item.order.toString(),
                style: theme.labelSmall?.copyWith(color: Colors.grey.shade300),
              ))
        ],
      ),
    );
  }
}
