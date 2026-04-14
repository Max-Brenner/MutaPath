process METABOLIC_IMPACT_ENGINE {
    tag "$meta_id.id"
    label 'process_low'
    container 'ubuntu:22.04'

    input:
    tuple val(meta_id), path(pathways)

    output:
    tuple val(meta_id), path("*.metabolic.json"), emit: metabolic

    script:
    """
    metabolic_impact_engine.py --input ${pathways} --out ${meta_id.id}.metabolic.json
    """

    stub:
    """
    touch ${meta_id.id}.metabolic.json
    """

}
