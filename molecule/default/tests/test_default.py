import os
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_asdf_installed(host):
    """Verify that asdf is installed in the user's home directory"""
    user = host.user()
    asdf_dir = host.file(f"{user.home}/.asdf")
    assert asdf_dir.exists, f"The directory {user.home}/.asdf does not exist"
    assert asdf_dir.is_directory, f"{user.home}/.asdf is not a directory"


def test_user_environment(host):
    """Verify the user and their home directory (diagnostic)"""
    user = host.user()
    assert user.name, "Could not determine the user name"
    assert user.home, f"Could not determine the home directory for user: {user.name}"


def test_python_installed(host):
    """Verify that Python is installed"""
    python = host.run("python3 --version")
    assert python.rc == 0, "Python3 is not installed or not executable"


def test_shell_configuration(host):
    """Verify that asdf is sourced in the shell configuration"""
    user = host.user()
    bashrc = host.file(f"{user.home}/.bashrc")
    assert bashrc.exists, f"{user.home}/.bashrc does not exist"
    assert ".asdf/asdf.sh" in bashrc.content_string, "asdf.sh is not sourced in .bashrc"


def test_asdf_executable(host):
    """Verify that the asdf executable exists"""
    user = host.user()
    asdf_bin = host.file(f"{user.home}/.asdf/bin/asdf")
    assert asdf_bin.exists, f"The asdf binary {user.home}/.asdf/bin/asdf does not exist"
    assert asdf_bin.is_file, f"{user.home}/.asdf/bin/asdf is not a file"


def test_asdf_version(host):
    """Verify the installed asdf version"""
    user = host.user()
    asdf = host.run(f"{user.home}/.asdf/bin/asdf --version")
    assert asdf.rc == 0, "Failed to run asdf --version"
    assert "v0.14.1" in asdf.stdout, "Expected asdf version v0.14.1 not found"


def test_asdf_shims(host):
    """Checks the presence of the asdf shims directory"""
    user = host.user()
    shims_dir = host.file(f"{user.home}/.asdf/shims")
    assert (
        shims_dir.exists
    ), f"The shims directory {user.home}/.asdf/shims does not exist"
    assert shims_dir.is_directory, f"{user.home}/.asdf/shims is not a directory"
