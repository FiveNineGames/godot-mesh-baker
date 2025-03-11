@tool
class_name MeshBaker
extends Node3D

@export_tool_button("Bake", "Callable") var bake_action: Callable = bake

@export_group("Settings")
@export var applied_scale: Vector3 = Vector3(1.0, 1.0, 1.0)
@export var source_meshes: Array[MeshInstance3D]


func bake() -> void:
	for mesh in source_meshes:
		var baked_mesh := ArrayMesh.new()
		mesh.bake_mesh_from_current_skeleton_pose(baked_mesh)

		var baked_name := mesh.name + "_Bake"
		var existing_node: Node = find_child(baked_name)

		if existing_node:
			remove_child(existing_node)

		var mesh_instance := MeshInstance3D.new()
		mesh_instance.name = baked_name
		mesh_instance.mesh = baked_mesh
		mesh_instance.scale = applied_scale
		mesh_instance.skeleton = NodePath("")

		add_child(mesh_instance)
		mesh_instance.owner = get_tree().edited_scene_root
