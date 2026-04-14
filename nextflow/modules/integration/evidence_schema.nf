process EVIDENCE_SCHEMA {
    tag "$meta_id.id"
    label 'process_low'
    container 'ubuntu:22.04'

    input:
    tuple val(meta_id), path(protein), path(metabolic)

    output:
    tuple val(meta_id), path("*.evidence.json"), emit: schema

    script:
    """
    evidence_schema.py --protein ${protein} --metabolic ${metabolic} --out ${meta_id.id}.evidence.json
    """

    stub:
    """
    touch ${meta_id.id}.evidence.json
    """

}
