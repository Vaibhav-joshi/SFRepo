import { LightningElement } from "lwc";

export default class JsonParserUtil extends LightningElement {
  jsonInput;
  nodes = [];
  nodeDetails = [];
  constructor() {
    super();
    this.jsonInput = undefined;
    this.nodes = [];
    this.nodeDetails = [];
  }
  validateJson(event) {
    this.jsonInput = this.isValidJson(event.target.value);

    if (this.jsonInput == undefined) {
      alert("Bad json");
      return;
    }
    this.getNodes();
    this.processNodeDetails();
    alert(this.nodeDetails);
  }

  isValidJson(input) {
    try {
      return JSON.parse(input);
    } catch (error) {
      console.error("Invalid JSON:", error);
      return undefined;
    }
  }

  getNodes() {
    this.nodes = Object.keys(this.jsonInput);
  }

  processNodeDetails() {
    this.nodeDetails = [];
    this.nodes.forEach((node) => {
      const nodeData = this.jsonInput[node];
      if (Array.isArray(nodeData)) {
        this.processArrayNodes(node, nodeData);
      } else {
        this.processObjectNode(node, nodeData);
      }
    });
  }

  processArrayNodes(node, nodeData) {
    const uniqueKey = node.slice(0, -1) + "Id";
    const nodeKeys = nodeData.map((item) => item[uniqueKey]);
    this.nodeDetails.push({
      nodeName: node,
      totalNodeSize: nodeData.length,
      nodeKeyList: nodeKeys
    });
  }
  processObjectNode(node, nodeData) {
    this.nodeDetails.push({
      nodeName: node,
      nodeKeyList: nodeData
    });
  }
}