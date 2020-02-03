

import 'dart:async';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class JumpToController{
  
  //final listViewKey;
  var listViewKey = RectGetter.createGlobalKey();
  var sectionItemKeys = {};
  var scrollController = new ScrollController();

  JumpToController();
  
  List<int> getVisible() {
    /// 先获取整个ListView的rect信息，然后遍历map
    /// 利用map中的key获取每个item的rect,如果该rect与ListView的rect存在交集
    /// 则将对应的index加入到返回的index集合中
    var rect = RectGetter.getRectFromKey(listViewKey);
    var _items = <int>[];
    sectionItemKeys.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);
      if (itemRect != null && !(itemRect.top > rect.bottom || itemRect.bottom < rect.top)) _items.add(index);
    });

    /// 这个集合中存的就是当前处于显示状态的所有item的index
    return _items;
  }

  void scrollLoop(int target, Rect listRect) {
    var first = getVisible().first;
    bool direction = first < target;
    Rect _rect;
    if (sectionItemKeys.containsKey(target)) _rect = RectGetter.getRectFromKey(sectionItemKeys[target]);
    if (_rect == null || (direction ? _rect.bottom < listRect.top : _rect.top > listRect.bottom)) {
      var offset = scrollController.offset + (direction ? listRect.height / 2 : -listRect.height / 2);
      offset = offset < 0.0 ? 0.0 : offset;
      offset = offset > scrollController.position.maxScrollExtent ? scrollController.position.maxScrollExtent : offset;
      scrollController.jumpTo(offset);
      Timer(Duration.zero, () {
        scrollLoop(target, listRect);
      });
      return;
    }
    final os = scrollController.offset + _rect.top - listRect.top;
    scrollController.animateTo(os, curve: Curves.linear, duration: Duration (milliseconds: 800));
    //scrollController.jumpTo(os);
  }

  void jumpTo(int target, bool disableReverseJump) {

    if (disableReverseJump){
      var visible = getVisible();
      if (visible.contains(target)) return;
    }

    var listRect = RectGetter.getRectFromKey(listViewKey);
    scrollLoop(target, listRect);
  }

}