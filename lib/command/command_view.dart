import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:code_snippets/command/command.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class CommandView extends StatefulWidget {
  final Command command;

  const CommandView(this.command, {super.key});

  @override
  State<CommandView> createState() => _CommandViewState();
}

class _CommandViewState extends State<CommandView> {
  Widget buildToast(BuildContext context, shadcn.ToastOverlay overlay) {
    return shadcn.SurfaceCard(
      child: shadcn.Basic(
        leading: Icon(Icons.check),
        title: const Text('Copiado para a área de transferência'),
        trailingAlignment: Alignment.bottomRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: shadcn.Tooltip(
                tooltip: shadcn.TooltipContainer(
                  child: Text(widget.command.headerValue),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(
                        widget.command.isExpanded ? 0 : 8,
                      ),
                      bottomRight: Radius.circular(
                        widget.command.isExpanded ? 0 : 8,
                      ),
                    ),
                    border: Border(
                      top: BorderSide(color: Colors.white10),
                      left: BorderSide(color: Colors.white10),
                      right: BorderSide(color: Colors.white10),
                      bottom:
                          widget.command.isExpanded
                              ? BorderSide.none
                              : BorderSide(color: Colors.white10),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      widget.command.isExpanded =
                      !widget.command.isExpanded;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.7,
                          child: Text(
                            widget.command.headerValue,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          widget.command.isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 18,
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: widget.command.headerValue),
                            );
                            shadcn.showToast(
                              context: context,
                              builder: buildToast,
                              location: shadcn.ToastLocation.bottomRight,
                            );
                          },
                          icon: Icon(Icons.copy, size: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (widget.command.isExpanded)
              Container(
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border(
                    left: BorderSide(color: Colors.white10),
                    right: BorderSide(color: Colors.white10),
                    bottom: BorderSide(color: Colors.white10),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Text(widget.command.expandedValue),
              ),
          ],
        );
      },
    );
  }
}
