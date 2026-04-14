process PATHWAY_MAPPER {
    tag "$meta_id.id"
    label 'process_low'
    container 'ubuntu:22.04'

    input:
    tuple val(meta_id), path(annotated)

    output:
    tuple val(meta_id), path("*.pathways.json"), emit: pathways

    script:
    """
    pathway_mapper.py --input ${annotated} --out ${meta_id.id}.pathways.json
    """

    stub:
    """
    touch ${meta_id.id}.pathways.json
    """

}
