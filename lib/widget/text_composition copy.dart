library text_composition;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// * 暂不支持图片
/// * 文本排版
/// * 两端对齐
/// * 底栏对齐
class TextComposition {
  /// 待渲染文本内容
  /// 已经预处理: 不重新计算空行 不重新缩进
  final String text;

  /// 待渲染文本内容
  /// 已经预处理: 不重新计算空行 不重新缩进
  List<String> _paragraphs;
  List<String> get paragraphs => _paragraphs;

  /// 容器宽度
  final double boxWidth;

  /// 容器高度
  final double boxHeight;

  /// 字体样式 字号 行高 字体 字色
  final TextStyle style;

  /// 段间距
  final int paragraph;

  /// 是否底栏对齐
  final bool shouldJustifyHeight;

  /// 每一页内容
  List<TextPage> _pages;
  List<TextPage> get pages => _pages;
  int get pageCount => _pages.length;

  /// 全部内容
  List<TextLine> _lines;
  List<TextLine> get lines => _lines;
  int get lineCount => _lines.length;

  final Pattern linkPattern;
  final TextStyle linkStyle;
  final String Function(String s) linkText;
  final void Function(String s) onLinkTap;

  /// * 文本排版
  /// * 两端对齐
  /// * 底栏对齐
  ///
  ///
  /// * [text] 待渲染文本内容 已经预处理: 不重新计算空行 不重新缩进
  /// * [paragraphs] 待渲染文本内容 已经预处理: 不重新计算空行 不重新缩进
  /// * [paragraphs] 为空时使用[text], 否则忽略[text],
  /// * [size] 字号
  /// * [style] 字体样式 字号 行高 字体 字色
  /// * [height] 行高
  /// * [family] 字体
  /// * [boxWidth] 容器宽度
  /// * [boxHeight] 容器高度
  /// * [paragraph] 段间距
  /// * [shouldJustifyHeight] 是否底栏对齐
  TextComposition({
    List<String> paragraphs,
    this.text,
    this.style,
    this.paragraph = 10,
    this.shouldJustifyHeight = true,
    this.linkPattern,
    this.linkStyle,
    this.linkText,
    this.onLinkTap,
    @required this.boxWidth,
    @required this.boxHeight,
  }) {
    _paragraphs = paragraphs ?? text?.split("\n") ?? <String>[];
    _pages = <TextPage>[];
    _lines = <TextLine>[];

    /// [tp] 只有一行的`TextPainter` [offset] 只有一行的`offset`
    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    final offset = Offset(boxWidth, 1);
    final size = style?.fontSize ?? 14;
    final _height = (TextPainter(
      text: TextSpan(text: "高度", style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout())
        .height
        .toInt();
    final _boxHeight = boxHeight - _height;
    final _boxHeight2 = _boxHeight - paragraph;
    final _boxWidth = boxWidth - size;

    var paragraphCount = 0;
    var pageHeight = 0;
    var startLine = 0;

    /// 下一页 判断分页 依据: `_boxHeight` `_boxHeight2`是否可以容纳下一行
    void newPage() {
      _pages.add(TextPage(startLine, lines.length, pageHeight, paragraphCount));
      paragraphCount = 0;
      pageHeight = 0;
      startLine = lines.length;
    }

    /// 新段落
    void newParagraph() {
      if (pageHeight > _boxHeight2) {
        newPage();
      } else {
        pageHeight += paragraph;
        lines.add(TextLine(paragraphGap: true));
        paragraphCount++;
      }
    }

    for (var p in _paragraphs) {
      if (linkPattern != null && p.startsWith(linkPattern)) {
        pageHeight += _height;
        lines.add(TextLine(text: p, link: true));
        newParagraph();
      } else
        while (true) {
          pageHeight += _height;
          tp.text = TextSpan(text: p, style: style);
          tp.layout(maxWidth: boxWidth);
          final textCount = tp.getPositionForOffset(offset).offset;
          if (p.length == textCount) {
            lines.add(TextLine(
                text: p,
                textCount: textCount,
                width: tp.width,
                shouldJustifyWidth: tp.width > _boxWidth));
            newParagraph();
            break;
          } else {
            lines.add(TextLine(
                text: p.substring(0, textCount),
                textCount: textCount,
                width: tp.width,
                shouldJustifyWidth: true));
            p = p.substring(textCount);
          }
          if (pageHeight > _boxHeight) {
            newPage();
          }
        }
    }
    if (lines.length > startLine) {
      _pages.add(
          TextPage(startLine, lines.length, pageHeight, paragraphCount, false));
    }
  }

  TextSpan getLineView(TextLine line, TextPainter tp) {
    if (line.textCount == 0) return TextSpan(text: "\n \n");
    if (line.shouldJustifyWidth) {
      tp.text = TextSpan(text: line.text, style: style);
      tp.layout();
      return TextSpan(
        text: line.text,
        style: TextStyle(
          letterSpacing: (boxWidth - 1 - tp.width) / line.textCount,
        ),
      );
    }
    return TextSpan(text: line.text);
  }

  List<TextSpan> getPageSpans(TextPage page) {
    var paragraphJustifyHeight = paragraph.toDouble();
    var restJustifyHeight = 0;
    if (shouldJustifyHeight && page.shouldJustifyHeight) {
      final rest = boxHeight.ceil() - page.height;
      restJustifyHeight = rest % page.paragraphCount;
      paragraphJustifyHeight += rest ~/ page.paragraphCount;
    }
    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    return lines.sublist(page.startLine, page.endLine).map((line) {
      if (line.link) {
        return TextSpan(
          text: "${linkText?.call(line.text) ?? line.text}",
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => onLinkTap?.call(line.text),
        );
      }
      if (line.paragraphGap) {
        /// restJustifyHeight 趋于 0
        if (restJustifyHeight-- > 0) {
          return TextSpan(
            text: "\n \n",
            style: TextStyle(
              fontSize: paragraphJustifyHeight + 1,
              height: 1,
            ),
          );
        }
        return TextSpan(
          text: "\n \n",
          style: TextStyle(
            fontSize: paragraphJustifyHeight,
            height: 1,
          ),
        );
      }
      return getLineView(line, tp);
    }).toList();
  }

  Widget getPageWidget(TextPage page,
      [bool debug = false, bool useCanvas = false]) {
    final ts = TextSpan(style: style, children: getPageSpans(page));

    if (debug) {
      var paragraphJustifyHeight = paragraph;
      var restJustifyHeight = 0;
      if (shouldJustifyHeight && page.shouldJustifyHeight) {
        final rest = boxHeight.ceil() - page.height;
        restJustifyHeight = rest % page.paragraphCount;
        paragraphJustifyHeight += rest ~/ page.paragraphCount;
      }
      print("****** 一页开始 ******");
      print("序号 预期 实际 内容");
      final tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
      var pageHeight = 0;
      for (var i = page.startLine; i < page.endLine; i++) {
        tp.maxLines = i + 1;
        tp.layout(maxWidth: boxWidth);
        final line = lines[i];
        final height = (TextPainter(
          text: TextSpan(text: "高度", style: style),
          textDirection: TextDirection.ltr,
          maxLines: 1,
        )..layout())
            .height
            .round();
        if (line.paragraphGap) {
          if (restJustifyHeight-- > 0) {
            pageHeight += paragraphJustifyHeight + 1;
          } else {
            pageHeight += paragraphJustifyHeight;
          }
        } else {
          pageHeight += height;
        }
        print("$i $pageHeight ${tp.height.toInt()} ${line.text}");
      }
      print("****** 一页结束 ******");
    }

    if (useCanvas) {
      final tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
      tp.maxLines = null;
      tp.layout(maxWidth: boxWidth);
      return Container(
        width: boxWidth,
        height: boxHeight,
        child: CustomPaint(painter: TextPainterPainter(tp)),
      );
    }

    return Container(
      width: boxWidth,
      height: boxHeight,
      child: RichText(text: ts),
    );
  }
}

class TextPainterPainter extends CustomPainter {
  final TextPainter tp;
  TextPainterPainter(this.tp);

  @override
  void paint(Canvas canvas, Size size) {
    tp.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class TextPage {
  final int startLine;
  final int endLine;
  final int paragraphCount;
  final int height;
  final bool shouldJustifyHeight;
  TextPage(this.startLine, this.endLine, this.height, this.paragraphCount,
      [this.shouldJustifyHeight = true]);
}

class TextLine {
  final String text;
  final int textCount;
  final double width;
  final bool paragraphGap;
  final bool shouldJustifyWidth;
  final bool link;
  TextLine({
    this.text = "",
    this.textCount = 0,
    this.width = 0,
    this.link = false,
    this.paragraphGap = false,
    this.shouldJustifyWidth = false,
  });
}
