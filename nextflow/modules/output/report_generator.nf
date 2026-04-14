process REPORT_GENERATOR {
    tag "$meta_id.id"
    label 'process_low'
    container 'ubuntu:22.04'

    input:
    tuple val(meta_id), path(reasoning)

    output:
    tuple val(meta_id), path("*.report.md"), path("*.report.html"), emit: report

    script:
    """
    report_generator.py --input ${reasoning} --out ${meta_id.id}.report
    """

    stub:
    """
    touch ${meta_id.id}.report.md
    touch ${meta_id.id}.report.html
    """

}
