require_relative 'DataStructure'

$n1 = PolyTreeNode.new("root1")
$n2 = PolyTreeNode.new("root2")
$n3 = PolyTreeNode.new("root3")
$n4 = PolyTreeNode.new("root4")
$n5 = PolyTreeNode.new("root5")
$n6 = PolyTreeNode.new("root6")
$n7 = PolyTreeNode.new("root7")

$n1.add_child($n2)
$n1.add_child($n3)
$n2.add_child($n4)
$n2.add_child($n5)
$n3.add_child($n6)
$n3.add_child($n7)
