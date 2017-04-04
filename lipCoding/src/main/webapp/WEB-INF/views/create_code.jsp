<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.1.1.min.js"></script>
<script src="resources/dia2/go.js"></script>
<script src="resources/dia2/goSamples.js"></script>
<script src="resources/dia2/DataInspector.js"></script>

<!-- CSS -->
<link href="resources/css/layout.css" rel="stylesheet">
<link href="resources/css/style_createCode.css" rel="stylesheet">
<link rel="stylesheet" href="resources/dia2/DataInspector.css" />

<script>
//다이어그램
$(document).ready(function() {
	$("#editor").on('keyup',call1);
});

function call1(){
	var text = $("#editor").text();
	text=text.slice(0,-50);
	text=text.replace(/[0-9]/g, "")
	console.log(text);
	$.ajax({
		url:'textparsing'
		, type:'POST'
		, data: {text: text}
		, dataType: 'json'
		, success: output
		, error: function(){
				}
	});
}

function output(ob){	
	$.each( ob, function(index,value){
		var parsing='';
		parsing += '{ "class": "go.TreeModel", "nodeDataArray": ';
		console.log(JSON.stringify(value));
		parsing +=JSON.stringify(ob);
		parsing+='}';
		$("#mySavedModel").val(parsing);
	});
	load();
}

function init() {
    var $ = go.GraphObject.make;  // for conciseness in defining templates

    myDiagram =
      $(go.Diagram, "myDiagramDiv", // must be the ID or reference to div
        {
          initialContentAlignment: go.Spot.Center,
          maxSelectionCount: 1, // users can select only one part at a time
          validCycle: go.Diagram.CycleDestinationTree, // make sure users can only create trees
          "clickCreatingTool.archetypeNodeData": {}, // allow double-click in background to create a new node
          "clickCreatingTool.insertPart": function(loc) {  // customize the data for the new node
            this.archetypeNodeData = {
              key: getNextKey(), // assign the key based on the number of nodes
              name: "(new person)",
              title: ""
            };
            return go.ClickCreatingTool.prototype.insertPart.call(this, loc);
          },
          layout:
            $(go.TreeLayout,
              {
                treeStyle: go.TreeLayout.StyleLastParents,
                arrangement: go.TreeLayout.ArrangementHorizontal,
                // properties for most of the tree:
                angle: 90,
                layerSpacing: 35,
                // properties for the "last parents":
                alternateAngle: 90,
                alternateLayerSpacing: 35,
                alternateAlignment: go.TreeLayout.AlignmentBus,
                alternateNodeSpacing: 20
              }),
          "undoManager.isEnabled": true // enable undo & redo
        });

    // when the document is modified, add a "*" to the title and enable the "Save" button
    myDiagram.addDiagramListener("Modified", function(e) {
      var button = document.getElementById("SaveButton");
      if (button) button.disabled = !myDiagram.isModified;
      var idx = document.title.indexOf("*");
      if (myDiagram.isModified) {
        if (idx < 0) document.title += "*";
      } else {
        if (idx >= 0) document.title = document.title.substr(0, idx);
      }
    });

    // manage boss info manually when a node or link is deleted from the diagram
    myDiagram.addDiagramListener("SelectionDeleting", function(e) {
      var part = e.subject.first(); // e.subject is the myDiagram.selection collection,
                                    // so we'll get the first since we know we only have one selection
      myDiagram.startTransaction("clear boss");
      if (part instanceof go.Node) {
        var it = part.findTreeChildrenNodes(); // find all child nodes
        while(it.next()) { // now iterate through them and clear out the boss information
          var child = it.value;
          var bossText = child.findObject("boss"); // since the boss TextBlock is named, we can access it by name
          if (bossText === null) return;
          bossText.text = "";
        }
      } else if (part instanceof go.Link) {
        var child = part.toNode;
        var bossText = child.findObject("boss"); // since the boss TextBlock is named, we can access it by name
        if (bossText === null) return;
        bossText.text = "";
      }
      myDiagram.commitTransaction("clear boss");
    });

    var levelColors = ["#AC193D", "#2672EC", "#8C0095", "#5133AB",
                       "#008299", "#D24726", "#008A00", "#094AB2"];

    // override TreeLayout.commitNodes to also modify the background brush based on the tree depth level
    myDiagram.layout.commitNodes = function() {
      go.TreeLayout.prototype.commitNodes.call(myDiagram.layout);  // do the standard behavior
      // then go through all of the vertexes and set their corresponding node's Shape.fill
      // to a brush dependent on the TreeVertex.level value
      myDiagram.layout.network.vertexes.each(function(v) {
        if (v.node) {
          var level = v.level % (levelColors.length);
          var color = levelColors[level];
          var shape = v.node.findObject("SHAPE");
          if (shape) shape.fill = $(go.Brush, "Linear", { 0: color, 1: go.Brush.lightenBy(color, 0.05), start: go.Spot.Left, end: go.Spot.Right });
        }
      });
    };

    // This function is used to find a suitable ID when modifying/creating nodes.
    // We used the counter combined with findNodeDataForKey to ensure uniqueness.
    function getNextKey() {
      var key = nodeIdCounter;
      while (myDiagram.model.findNodeDataForKey(key) !== null) {
        key = nodeIdCounter--;
      }
      return key;
    }

    var nodeIdCounter = -1; // use a sequence to guarantee key uniqueness as we add/remove/modify nodes

    // when a node is double-clicked, add a child to it
    function nodeDoubleClick(e, obj) {
      var clicked = obj.part;
      if (clicked !== null) {
        var thisemp = clicked.data;
        myDiagram.startTransaction("add employee");
        var newemp = { key: getNextKey(), name: "(new person)", title: "", parent: thisemp.key };
        myDiagram.model.addNodeData(newemp);
        myDiagram.commitTransaction("add employee");
      }
    }

    // this is used to determine feedback during drags
    function mayWorkFor(node1, node2) {
      if (!(node1 instanceof go.Node)) return false;  // must be a Node
      if (node1 === node2) return false;  // cannot work for yourself
      if (node2.isInTreeOf(node1)) return false;  // cannot work for someone who works for you
      return true;
    }

    // This function provides a common style for most of the TextBlocks.
    // Some of these values may be overridden in a particular TextBlock.
    function textStyle() {
      return { font: "9pt  Segoe UI,sans-serif", stroke: "white" };
    }

    // This converter is used by the Picture.
    function findHeadShot(title) {
      if (title=="project"){ 
    	  return "resources/images/project.png"; 
      }
      if (title=="package"){ 
    	  return "resources/images/package.png"; 
      }
      if (title=="class"){ 
    	  return "resources/images/class.png"; 
      }
    }

    // define the Node template
    myDiagram.nodeTemplate =
      $(go.Node, "Auto",
        { doubleClick: nodeDoubleClick },
        { // handle dragging a Node onto a Node to (maybe) change the reporting relationship
          mouseDragEnter: function (e, node, prev) {
            var diagram = node.diagram;
            var selnode = diagram.selection.first();
            if (!mayWorkFor(selnode, node)) return;
            var shape = node.findObject("SHAPE");
            if (shape) {
              shape._prevFill = shape.fill;  // remember the original brush
              shape.fill = "darkred";
            }
          },
          mouseDragLeave: function (e, node, next) {
            var shape = node.findObject("SHAPE");
            if (shape && shape._prevFill) {
              shape.fill = shape._prevFill;  // restore the original brush
            }
          },
          mouseDrop: function (e, node) {
            var diagram = node.diagram;
            var selnode = diagram.selection.first();  // assume just one Node in selection
            if (mayWorkFor(selnode, node)) {
              // find any existing link into the selected node
              var link = selnode.findTreeParentLink();
              if (link !== null) {  // reconnect any existing link
                link.fromNode = node;
              } else {  // else create a new link
                diagram.toolManager.linkingTool.insertLink(node, node.port, selnode, selnode.port);
              }
            }
          }
        },
        // for sorting, have the Node.text be the data.name
        new go.Binding("text", "name"),
        // bind the Part.layerName to control the Node's layer depending on whether it isSelected
        new go.Binding("layerName", "isSelected", function(sel) { return sel ? "Foreground" : ""; }).ofObject(),
        // define the node's outer shape
        $(go.Shape, "Rectangle",
          {
            name: "SHAPE", fill: "white", stroke: null,
            // set the port properties:
            portId: "", fromLinkable: true, toLinkable: true, cursor: "pointer"
          }),
        $(go.Panel, "Horizontal",
          $(go.Picture,
            {
              name: "Picture",
              desiredSize: new go.Size(39, 50),
              margin: new go.Margin(6, 8, 6, 10),
            },
            new go.Binding("source", "title", findHeadShot)),
          // define the panel where the text will appear
          $(go.Panel, "Table",
            {
              maxSize: new go.Size(150, 999),
              margin: new go.Margin(6, 10, 0, 3),
              defaultAlignment: go.Spot.Left
            },
            $(go.RowColumnDefinition, { column: 2, width: 4 }),
            $(go.TextBlock, textStyle(),  // the name
              {
                row: 0, column: 0, columnSpan: 5,
                font: "12pt Segoe UI,sans-serif",
                editable: true, isMultiline: false,
                minSize: new go.Size(10, 16)
              },
              new go.Binding("text", "name").makeTwoWay()),
            $(go.TextBlock, "Title: ", textStyle(),
              { row: 1, column: 0 }),
            $(go.TextBlock, textStyle(),
              {
                row: 1, column: 1, columnSpan: 4,
                editable: true, isMultiline: false,
                minSize: new go.Size(10, 14),
                margin: new go.Margin(0, 0, 0, 3)
              },
              new go.Binding("text", "title").makeTwoWay()),
            $(go.TextBlock, textStyle(),
              { row: 2, column: 0 },
              new go.Binding("text", "key", function(v) {return "ID: " + v;})),
            $(go.TextBlock, textStyle(),
              { name: "boss", row: 2, column: 3, }, // we include a name so we can access this TextBlock when deleting Nodes/Links
              new go.Binding("text", "parent", function(v) {return "Boss: " + v;})),
            $(go.TextBlock, textStyle(),  // the comments
              {
                row: 3, column: 0, columnSpan: 5,
                font: "italic 9pt sans-serif",
                wrap: go.TextBlock.WrapFit,
                editable: true,  // by default newlines are allowed
                minSize: new go.Size(10, 14)
              },
              new go.Binding("text", "comments").makeTwoWay())
          )  // end Table Panel
        ) // end Horizontal Panel
      );  // end Node

    // the context menu allows users to make a position vacant,
    // remove a role and reassign the subtree, or remove a department
    myDiagram.nodeTemplate.contextMenu =
      $(go.Adornment, "Vertical",
        $("ContextMenuButton",
          $(go.TextBlock, "Vacate Position"),
          {
            click: function(e, obj) {
              var node = obj.part.adornedPart;
              if (node !== null) {
                var thisemp = node.data;
                myDiagram.startTransaction("vacate");
                // update the key, name, and comments
                myDiagram.model.setKeyForNodeData(thisemp, getNextKey());
                myDiagram.model.setDataProperty(thisemp, "name", "(Vacant)");
                myDiagram.model.setDataProperty(thisemp, "comments", "");
                myDiagram.commitTransaction("vacate");
              }
            }
          }
        ),
        $("ContextMenuButton",
          $(go.TextBlock, "Remove Role"),
          {
            click: function(e, obj) {
              // reparent the subtree to this node's boss, then remove the node
              var node = obj.part.adornedPart;
              if (node !== null) {
                myDiagram.startTransaction("reparent remove");
                var chl = node.findTreeChildrenNodes();
                // iterate through the children and set their parent key to our selected node's parent key
                while(chl.next()) {
                  var emp = chl.value;
                  myDiagram.model.setParentKeyForNodeData(emp.data, node.findTreeParentNode().data.key);
                }
                // and now remove the selected node itself
                myDiagram.model.removeNodeData(node.data);
                myDiagram.commitTransaction("reparent remove");
              }
            }
          }
        ),
        $("ContextMenuButton",
          $(go.TextBlock, "Remove Department"),
          {
            click: function(e, obj) {
              // remove the whole subtree, including the node itself
              var node = obj.part.adornedPart;
              if (node !== null) {
                myDiagram.startTransaction("remove dept");
                myDiagram.removeParts(node.findTreeParts());
                myDiagram.commitTransaction("remove dept");
              }
            }
          }
        )
      );

    // define the Link template
    myDiagram.linkTemplate =
      $(go.Link, go.Link.Orthogonal,
        { corner: 5, relinkableFrom: true, relinkableTo: true },
        $(go.Shape, { strokeWidth: 4, stroke: "#00a4a4" }));  // the link shape

    // read in the JSON-format data from the "mySavedModel" element
    load();


    // support editing the properties of the selected person in HTML
    if (window.Inspector) myInspector = new Inspector("myInspector", myDiagram,
      {
        properties: {
          "key": { readOnly: true },
          "comments": {}
        }
      });
  }

  // Show the diagram's model in JSON format
  function save() {
    document.getElementById("mySavedModel").value = myDiagram.model.toJson();
    myDiagram.isModified = false;
  }
  function load() {
    myDiagram.model = go.Model.fromJson(document.getElementById("mySavedModel").value);
  }

	$(document).ready(function(){
		voice();
	});
</script>

<script>
	function voice() {
		var final_transcript = '';
		var recognizing = false;
		var ignore_onend;
		var recognition = new webkitSpeechRecognition();
		recognition.continuous = true;
		recognition.interimResults = true;

		if (recognizing) {
			recognition.stop();
			alert('음성인식 종료');
			return;
		} else {
			final_transcript = '';
			recognition.lang = 'en-US';
			recognition.start();
			ignore_onend = false;
			console.log('음성인식 시작');
		}

		recognition.onend = function() {
			recognizing = false;
			if (ignore_onend) {
				return;
			}
			if (!final_transcript) {
				console.log('스타트하세옹');
				return;
			}
			console.log('');
			recognition.lang = 'en-US';
			recognition.start();
			ignore_onend = false;
			console.log('음성인식 시작');
		};

		recognition.onresult = function(event) {
			var interim_transcript = '';
			for (var i = event.resultIndex; i < event.results.length; ++i) {
					var command = event.results[i][0].transcript;
				if (event.results[i].isFinal) {
					var dbComm = command.toLowerCase();
					final_transcript += dbComm;
					if (final_transcript.match('hello')) {
						console.log('서버 연결 준비');
						var array = dbComm.split(' ');
						for (var j = 0; j < array.length; j++) {
							console.log(array[j]);
							$.ajax({
								url : 'userCode',
								type : 'POST',
								data : {
									command : array[j]
								},
								dataType : 'text',
								success : result,
								error : function(e) {
									alert(JSON.stringify(e));
								}
							});
						}
					} else
						console.log('매치안됨');
				}
			}
		};
	}
</script>
</head>
<body>
	<div id="divExp">

	</div>
	
	
	<div id="editor" contentEditable="true" ></div>
	
	
	<div id="diagram">
	 	<body onload="init()">
			<div id="sample">
	 			<div id="myDiagramDiv" style="/* background-color: #696969; */ border: solid 1px black; height: 600px; outline:none">
	 			</div>
			<div>
	  			<textarea id="mySavedModel" style="width:100%;height:250px;display:none" ></textarea>
	 		</div>
		</div>
 	</div>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.6/ace.js" type="text/javascript" charset="utf-8"></script>
	<script src="resources/js/ext-language_tools.js"></script>
	
	<script>
    // trigger extension
    ace.require("ace/ext/language_tools");
    var editor = ace.edit("editor");
    editor.session.setMode("ace/mode/java");
    editor.setTheme("ace/theme/monokai");
    // 자동완성
    editor.setOptions({
        enableBasicAutocompletion: true,
        enableSnippets: true,
        enableLiveAutocompletion: false
    });
    
    function result(ob) {
		editor.insert(ob);
    }
	</script>

</body>
</html>