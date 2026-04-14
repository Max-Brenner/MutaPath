process AI_REASONER {
    tag "$meta_id.id"
    label 'process_low'
    container 'ubuntu:22.04'

    input:
    tuple val(meta_id), path(evidence)

    output:
    tuple val(meta_id), path("*.reasoning.json"), emit: reasoning

    script:
    """
    ai_reasoner.py --input ${evidence} --out ${meta_id.id}.reasoning.json
    """

    stub:
    """
    touch ${meta_id.id}.reasoning.json
    """

}
