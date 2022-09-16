import os
from dataclasses import dataclass

from invoke import task


@dataclass
class AwsCred:
    aws_access_key_id: str
    aws_secret_access_key: str


def read_aws_cred() -> AwsCred:
    key = os.getenv('AWS_ACCESS_KEY_ID')
    secret = os.getenv('AWS_SECRET_ACCESS_KEY')
    if not key or not secret:
        raise Exception("AWS credentials are not set. Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY")
    return AwsCred(aws_access_key_id=key, aws_secret_access_key=secret)


def project_root_dir() -> str:
    return os.path.dirname(os.path.realpath(__file__))


def terraform_cmd(op, tf_vars="") -> str:
    aws_cred = read_aws_cred()
    env = f"-e AWS_ACCESS_KEY_ID={aws_cred.aws_access_key_id} -e AWS_SECRET_ACCESS_KEY={aws_cred.aws_secret_access_key}"
    vol = f"-v {project_root_dir()}/terraform:/terraform"
    ver = "latest"

    return f"docker run {env} {vol} hashicorp/terraform:{ver} -chdir=/terraform {op} {tf_vars}"


@task
def terraform_init(c, docs=False):
    c.run(terraform_cmd("init"))


@task
def terraform_apply(c, docs=False, env=None):
    if not env:
        raise Exception("Deployment environment is not set")
    tf_vars = f"-var='environment={env}'"
    c.run(terraform_cmd("apply", tf_vars))
