library text_composition;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  /// 字号
  final double size;

  /// 字体
  final String family;

  /// 行高
  final double height;

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

  /// * 文本排版
  /// * 两端对齐
  /// * 底栏对齐
  ///
  ///
  /// * [text] 待渲染文本内容 已经预处理: 不重新计算空行 不重新缩进
  /// * [paragraphs] 待渲染文本内容 已经预处理: 不重新计算空行 不重新缩进
  /// * [paragraphs] 为空时使用[text], 否则忽略[text],
  /// * [size] 字号
  /// * [height] 行高
  /// * [family] 字体
  /// * [boxWidth] 容器宽度
  /// * [boxHeight] 容器高度
  /// * [paragraph] 段间距
  /// * [shouldJustifyHeight] 是否底栏对齐
  TextComposition({
    List<String> paragraphs,
    this.text,
    this.size = 16.0,
    this.height = 1.55,
    this.family,
    this.paragraph = 10,
    this.shouldJustifyHeight = true,
    @required this.boxWidth,
    @required this.boxHeight,
  }) {
    _paragraphs = paragraphs ?? text?.split("\n") ?? <String>[];
    _pages = <TextPage>[];
    _lines = <TextLine>[];

    /// [tp] 只有一行的`TextPainter` [offset] 只有一行的`offset`
    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    final offset = Offset(boxWidth, 1);
    final style = TextStyle(fontSize: size, fontFamily: family, height: height);
    // final _height = size * height; //这个结果不行
    final _height = (size * height).round() + 1; //pixel用整数 向上取整就对了
    final _boxHeight = boxHeight - _height;
    final _boxHeight2 = _boxHeight - paragraph;
    final _boxWidth = boxWidth - size;

    var paragraphCount = 0;
    var pageHeight = 0;
    var startLine = 0;

    /// 下一页
    void newPage() {
      _pages.add(TextPage(startLine, lines.length, pageHeight, paragraphCount));
      paragraphCount = 0;
      pageHeight = 0;
      startLine = lines.length;
    }

    for (var p in _paragraphs) {
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
          if (pageHeight > _boxHeight2) {
            newPage();
          } else {
            pageHeight += paragraph;
            lines.add(TextLine(paragraphGap: true));
            paragraphCount++;
          }
          break;
        } else {
          lines.add(TextLine(
              text: p.substring(0, textCount),
              textCount: textCount,
              width: tp.width,
              shouldJustifyWidth: true));
          p = p.substring(textCount);
        }

        /// 段落结束 跳出循环 判断分页 依据: `_boxHeight` `_boxHeight2`是否可以容纳下一行
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

  TextSpan getLineView(TextLine line, TextPainter tp, TextStyle style) {
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

  //xxxx
  final ratio = Get.pixelRatio;

  TextSpan getPageView(TextPage page) {
    // var paragraphJustifyHeight = paragraph.toDouble();
    // var restJustifyHeight = 0;
    // if (shouldJustifyHeight && page.shouldJustifyHeight) {
    //   print("-->应该调整上下");
    //   final rest = (boxHeight.ceil() - page.height);
    //   print("rest-->" + rest.toString());
    //   restJustifyHeight = rest % page.paragraphCount;
    //   print("restJustifyHeight-->" + restJustifyHeight.toString());
    //   paragraphJustifyHeight += (rest ~/ page.paragraphCount);
    //   print("paragraphJustifyHeight-->" + paragraphJustifyHeight.toString());
    //   print('ratio-->' + ratio.toString());
    // }
    final style = TextStyle(
      height: height,
      fontSize: size,
      fontFamily: family,
    );
    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    return TextSpan(
      // style: style,
      children: [
        WidgetSpan(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lines.sublist(page.startLine, page.endLine).map((line) {
            return RichText(
              text: line.paragraphGap
                  ? TextSpan(
                      text: "\n   \n",
                      style: TextStyle(
                        fontSize: paragraph * 1.0,
                        height: 1,
                      ),
                    )
                  : getLineView(line, tp, style),
            );
          }).toList(),
        ))
      ],
    );
  }

  Widget getPageWidget(TextPage page) {
    final style = TextStyle(
      height: height,
      fontSize: size,
      fontFamily: family,
    );
    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    return Container(
      width: boxWidth,
      height: boxHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.sublist(page.startLine, page.endLine).map((line) {
          return RichText(
            text: line.paragraphGap
                ? TextSpan(
                    text: "\n   \n",
                    style: TextStyle(
                      fontSize: paragraph * 1.0,
                      height: 1,
                    ),
                  )
                : getLineView(line, tp, style),
          );
        }).toList(),
      ),
    );
  }

  // Widget getPageWidget(TextPage page) {
  //   final ts = TextSpan(
  //     style: style,
  //     children: getPageSpans(page),
  //   );

  //   final tpTest = TextPainter(
  //     textDirection: TextDirection.ltr,
  //     text: ts,
  //   );
  //   tpTest.layout(maxWidth: boxWidth);
  //   print(
  //       "${lines[page.startLine].text.substring(0, 5)} ${lines[page.endLine - 1].text.substring(0, 5)} tpTest.height ${tpTest.height} page.height ${page.height}");

  //   return Container(
  //     width: boxWidth,
  //     height: boxHeight,
  //     child: RichText(
  //       text: ts,
  //     ),
  //   );
  // }
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
  TextLine({
    this.text = "",
    this.textCount = 0,
    this.width = 0,
    this.paragraphGap = false,
    this.shouldJustifyWidth = false,
  });
}
