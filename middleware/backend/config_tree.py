from collections import defaultdict

class ConfigurationTree:
    def __init__(self, table, column_names):
        """
        Initialize the ConfigurationTree object.
        
        :param table: A list of tuples where each tuple represents a row in the table.
        :param column_names: A list of attribute/column names corresponding to the table's columns.
        """
        self.table = table
        self.column_names = column_names
        self.tree = defaultdict(list)
        self.attr_scores = {}
        self.num_tuples = len(table)
        self.attributes = self._extract_attributes()
    
    def _extract_attributes(self):
        """
        Extract attributes from the table based on column names.
        
        :return: A dictionary where keys are attribute names and values are lists of attribute values.
        """
        return {attr: [row[idx] for row in self.table] for idx, attr in enumerate(self.column_names)}
    
    def _calculate_attribute_scores(self):
        """
        Calculate scores for each attribute based on unique and non-missing values.
        """
        for attr, values in self.attributes.items():
            non_missing_values = [v for v in values if v is not None]
            unique_values = len(set(non_missing_values))
            self.attr_scores[attr] = min(len(non_missing_values) / self.num_tuples, unique_values / len(non_missing_values))
    
    def generate_tree(self):
        """
        Generate the configuration tree in a top-down fashion.
        """
        self._calculate_attribute_scores()
        sorted_attributes = sorted(self.attr_scores, key=self.attr_scores.get, reverse=True)
        
        current_node = sorted_attributes
        for attr in sorted_attributes:
            child_node = [x for x in current_node if x != attr]
            self.tree[tuple(current_node)].append(tuple(child_node))
            current_node = child_node
    
    def get_tree(self):
        """
        Retrieve the generated configuration tree.
        
        :return: The configuration tree as a dictionary.
        """
        if not self.tree:
            self.generate_tree()
        return self.tree

    def print_tree(self):
        """
        Print the configuration tree in a readable format.
        """
        if not self.tree:
            self.generate_tree()
        for parent, children in self.tree.items():
            print(f"Parent: {parent} -> Children: {children}")


# Example usage
import requests
url = "http://127.0.0.1:5000/api/doctors_schema_and_data"
response = requests.get(url)

if response.status_code == 200:
    data = response.json()  # Get the JSON response
    table = data.get("data", [])  # Extract the data
    column_names = data.get("schema", [])  # Extract the schema (column names)

    # Create ConfigurationTree instance and print the tree
    if table and column_names:
        config_tree_obj = ConfigurationTree(table, column_names)
        config_tree_obj.print_tree()  # Print the configuration tree
    else:
        print("Error: Empty data or schema received.")
else:
    print(f"Error: Unable to fetch data. HTTP Status Code: {response.status_code}")