process PROTEIN_EFFECTS {
    tag "$meta_id.id"
    label 'process_medium'
    container 'ubuntu:22.04'

    input:
    tuple val(meta_id), path(vep_json)

    output:
    tuple val(meta_id), path("*.protein.json"), emit: effects

    script:
    """
    protein_effects.py --input ${vep_json} --out ${meta_id.id}.protein.json
    """

    stub:
    """
    touch ${meta_id.id}.protein.json
    """

}
