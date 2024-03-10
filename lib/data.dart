import 'dart:convert';


import 'package:flutter/material.dart';

class Document {
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);
  
  (Type, {DateTime modified}) getMetdata() {
    if (_json
    case  {
      'metadata': {
        'title': String title,
        'modified': String localModified,
      }
    
    }){
    return(Title, modified: DateTime.parse(localModified));
    }else {
    throw const FormatException('Unexpected JSON');
    }
  }
}

class Block {
  final Map<String, Object?> _json;
  final String type;
  final String text;
  Block(this.type, this.text);

  factory Block.formJson(Map<String, dynamic> json){
    if(json case {'type': var type, 'text': var text}) {
      return Block(type, text);
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
}
List <Block> getBlocks(){
  if (_json case{'blocks': List blocksJson}) {
    return <Block>[
      for (var blockJson in blocksJson) Block.formJson(blockJson)
    ];
  }else {
    throw const FormatException('Unexpected JSON format');
  }
}

class HeaderBlock extends Block {
  final String text;
  HeaderBlock(this.text);
}

class ParagraphBlock extends Block {
  final String text;
  ParagraphBlock(this.text);
}

class CheckboxBlock extends Block {
  final String text;
  final bool isChecked;
  CheckboxBlock(this.text, this.isChecked);
}
sealed class Block {
  Block();

  factory Block.fromJson(Map<String, Object?> json) {
    return switch (json) {
      {'type': 'h1', 'text': String text} => HeaderBlock(text),
      {'type': 'p', 'text': String text} => ParagraphBlock(text),
      {'type': 'checkbox', 'text': String text, 'checked': bool checked} =>
        CheckboxBlock(text, checked),
      _ => throw const FormatException('Unexpected JSON format'),
    };
  }
}

const documentJson = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2024-03-08"
  
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
  {
    "metadata": {
      //..
    },
    "blocks":[
      {
        "type": "h1",
        "text": "chapther 1"
      },
      //...
    ]
  }
}

''';